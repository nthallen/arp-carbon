/* BS2cdf.cc */
#include <stdarg.h>
#include <stdlib.h>
#include <ctype.h>
#include <strings.h>
#include <time.h>
#include <math.h>
#include "BS2cdf.h"
#include "nl_assert.h"

const char *data_path;
const char *setup_path;
int all_recs = 0;

/** Parses configuration line to initialize member fields.
    In the event of a syntax error, valid will be false.
    If device is -99, valid will be false and device will be
    -99, but no other fields will be initialized.
*/
BS2Cchan::BS2Cchan(const char *line, const char *filename, int ln) {
  int i, n, nc;
  device = 0;
  valid = false;
  cfg = line;
  file = filename;
  line_num = ln;
  cp = 0;
  
  if (parse_str(&label[0], sizeof(label), "label")) return;
  n = sscanf(&cfg[cp], "%hd%hd%hd%n", &device, &physicalChannel,
        &frequency, &nc);
  if (n == 1 && device == -99) return;
  else if (chk_sscanf(n != 3, nc, "device, channel or frequency"))
    return;
  if (parse_str(&units[0], sizeof(units), "units")) return;
  n = sscanf(&cfg[cp], "%hd%n", &cal_pwr, &nc);
  if (chk_sscanf(n != 1, nc, "cal_pwr")) return;
  if (cal_pwr > 5) {
    nl_error(2, "%s:%d Invalid cal_pwr: %d", file, line_num, cal_pwr);
    return;
  }
  for (i = 0; i < cal_pwr; ++i) {
    n = sscanf(&cfg[cp], "%f%n", &coef[i], &nc);
    if (chk_sscanf(n != 1, nc, "coef")) return;
  }
  for (; i < 5; ++i) coef[i] = 0.;
  n = sscanf(&cfg[cp], "%f%f%n", &min, &max, &nc);
  if (chk_sscanf(n != 2, nc, "min or max")) return;
  if (parse_str(&cFormat[0], sizeof(cFormat), "cFormat")) return;
  if (strcasecmp(cFormat, "NC_CHAR") == 0)
    cFormat_code = NC_CHAR;
  else if (strcasecmp(cFormat, "NC_SHORT") == 0)
    cFormat_code = NC_SHORT;
  else if (strcasecmp(cFormat, "NC_INT") == 0)
    cFormat_code = NC_INT;
  else {
    cFormat_code = 0;
    nl_error(2, "%s:%d Invalid cFormat for %s: '%s'",
        file, line_num, label, cFormat);
  }
  n = sscanf(&cfg[cp], "%f%f%n", &scaleFactor, &addOffset, &nc);
  if (chk_sscanf(n != 2, nc, "scaleFactor or addOffset"))
    return;
  if (parse_str(&longName[0], sizeof(longName), "longName", 1))
    return;
  valid = true;
}

BS2Cchan::~BS2Cchan() {}

int BS2Cchan::chk_sscanf(int bad_ret, int nc, const char *what) {
  if (bad_ret) {
    nl_error(2, "%s:%d Syntax error reading %s for channel %s",
      file, line_num, what, label);
    return 1;
  }
  cp += nc;
  return 0;
}

void BS2Cchan::chk_attr(const char *attr, int nc_err) {
  if (nc_err != NC_NOERR)
    nl_error(3, "Couldn't put %s attribute for var %s. nc_err=%d",
      attr, label, nc_err);
}

/** @return non-zero if no string is found or string is more than len-1 characters.
 */
int BS2Cchan::parse_str(char *ibuf, int len, const char *strname, int ws_ok) {
  int n = 0;
  while (cfg[cp] && isspace(cfg[cp])) ++cp;
  while (cfg[cp] && (ws_ok || !isspace(cfg[cp]))) {
    if (n+1 >= len) {
      nl_error(2, "%s:%d String overflow parsing %s", file, line_num, strname);
      return 1;
    }
    ibuf[n++] = cfg[cp++];
  }
  // Trim trailing whitespace
  while (ws_ok && n > 0 && isspace(ibuf[n-1]))
    --n;
  ibuf[n] = '\0';
  return n == 0;
}

BS2Cdim::BS2Cdim(short freq) {
  frequency = freq;
  dim_id = -1;
}

unsigned char BS2cdf::ibuf[BS2cdf::n_rec][BS2cdf::nb_rec];

BS2cdf::BS2cdf() {
  ncid = -1;
  opened = false;
  cur_time = 0;
  cur_rec = -1;
  scan = 0;
  BAT_saved = false;
}

BS2cdf::~BS2cdf() {
  nc_close();
}

const char *BS2cdf::back_tick(const char *fmt, ...) {
  char cmd[80];
  static char output[80];
  FILE *fp;
  va_list args;
  int nc;

  va_start(args, fmt);
  vsnprintf(cmd, 79, fmt, args);
  va_end(args);
  fp = popen(cmd, "r");
  if (fp == NULL)
    nl_error(3, "Error invoking command: '%s'");
  nc = fread(output, 1, 79, fp);
  if (nc >= 79) {
    nl_error(1, "Possible overflow from subcommand '%s'", cmd);
    nc = 79;
  }
  while (nc > 0 && isspace(output[nc-1]))
    --nc;
  output[nc] = '\0';
  fclose(fp);
  return output;
}

mlf_def_t *BS2cdf::mlf_init(const char *data_path) {
  mlf_def_t *mlf;
  const char *config;
  mlf_ntup_t *mlfn;

  if (data_path && chdir(data_path))
    nl_error(3, "Unable to chdir(%s)", data_path);
  mlf = ::mlf_init(3, 60, 0, "BAT_SPAN", "dat", NULL);
  config = back_tick("mlf_find %s", "BAT_SPAN");
  mlfn = mlf_convert_fname(mlf, "BAT_SPAN", config);
  mlf_set_ntup(mlf, mlfn);
  last_idx = mlf->index;
  mlf_free_mlfn(mlfn);
  config = back_tick("mlf_find -f %s", "BAT_SPAN");
  mlfn = mlf_convert_fname(mlf, "BAT_SPAN", config);
  mlf_set_ntup(mlf, mlfn);
  mlf_free_mlfn(mlfn);
  nl_error(0, "Will extract from %lu to %lu", mlf->index, last_idx);
  return mlf;
}

void BS2cdf::nc_setup(const char *data_path, const char *setup_path) {
  int nc_err, nc;
  char setup[160];
  FILE *ifp;
  char title[100], date[20];
  char chan_def[250];
  struct tm *d;
  time_t now;

  nc_err = nc_create("BAT_SPAN.ncr", NC_CLOBBER, &ncid);
  if (nc_err != NC_NOERR)
    nl_error(3, "Unable to create BAT_SPAN.ncr");
  opened = true;
  nc_err = nc_def_dim(ncid, "scan", NC_UNLIMITED, &scan_dimid);
  if (nc_err != NC_NOERR)
    nl_error(3, "Error creating unlimited scan dimension");
  
  if (setup_path == NULL) {
    if (data_path == NULL) data_path = ".";
    snprintf(setup, 160, "%s/BAT_setup.txt", data_path);
    setup_path = &setup[0];
  }
  ifp = fopen(setup_path, "r");
  if (ifp == NULL)
    nl_error(3, "Unable to read setup file: '%s'", setup_path);
  line_num = 1;
  if (fgets(title, sizeof(title), ifp) == NULL)
    nl_error(3, "%s:%d Unexpected EOF reading title", setup_path, line_num);
  nc = strlen(title);
  while (nc > 0 && isspace(title[nc-1]))
    title[--nc] = '\0';
  nc_err = nc_put_att_text(ncid, NC_GLOBAL, "title", nc, title);
  if (nc_err != NC_NOERR)
    nl_error(3, "Error setting title");

  now = time(NULL);
  d = localtime(&now);
  snprintf(date, sizeof(date), "%02d/%02d/%04d", d->tm_mon+1, d->tm_mday, d->tm_year+1900);
  nc_err = nc_put_att_text(ncid, NC_GLOBAL, "date", strlen(date), date);
  if (nc_err != NC_NOERR)
    nl_error(3, "Error setting date");

  /* Swallow device definitions */
  for(;;) {
    ++line_num;
    if (fgets(chan_def, sizeof(chan_def), ifp) == NULL)
      nl_error(3, "%s:%d Unexpected end of file in setup file", setup_path, line_num);
    if (strlen(chan_def)+1 >= sizeof(chan_def))
      nl_error(3, "%s:%d Input line too long", setup_path, line_num);
    if(atoi(chan_def) == -99) break;
  }
  
  /* Now read channel definitions */
  for(;;) {
    BS2Cchan *BC;
    ++line_num;
    if (fgets(chan_def, sizeof(chan_def), ifp) == NULL)
      nl_error(3, "%s:%d Unexpected end of file in setup file", setup_path, line_num);
    if (strlen(chan_def)+1 >= sizeof(chan_def))
      nl_error(3, "%s:%d Input line too long in setup file", setup_path, line_num);
    BC = new BS2Cchan(chan_def, setup_path, line_num);
    if (BC->valid) {
      unsigned i;
      chan.push_back(BC);
      if (BC->frequency > 1) {
        for (i = 0; i < dims.size(); ++i) {
          if (BC->frequency == dims[i].frequency) break;
        }
        if (i == dims.size())
          dims.push_back(BS2Cdim(BC->frequency));
      }
    } else {
      bool done = (BC->device == -99);
      delete BC;
      if (done) break;
    }
  }
  fclose(ifp);
  
  // Create dimensions
  { std::vector<BS2Cdim>::iterator pos;
    for (pos = dims.begin(); pos < dims.end(); ++pos) {
      char dim_name[10];
      int status;
      
      snprintf(dim_name, 10, "%02d_Hz", pos->frequency);
      status = nc_def_dim(ncid, dim_name, pos->frequency, &pos->dim_id);
      if (status != NC_NOERR)
        nl_error(3, "Error creating dimension frequency '%s'", dim_name);
    }
  }
  { std::vector<BS2Cchan *>::iterator pos;
    int dimids[2];
    dimids[0] = scan_dimid;
    for (pos = chan.begin(); pos < chan.end(); ++pos) {
      std::vector<BS2Cdim>::iterator dim;
      BS2Cchan *var = *pos;
      int num_dims;
      nc_type xtype;
      if (var->frequency > 1) {
        num_dims = 2;
        // find dimension...
        for (dim = dims.begin(); dim < dims.end(); ++dim) {
          if (dim->frequency == var->frequency) {
            dimids[1] = dim->dim_id;
            break;
          }
        }
      } else {
        num_dims = 1;
      }
      if (!strcasecmp(var->cFormat,"NC_CHAR"))
        xtype = NC_CHAR;
      else if (!strcasecmp(var->cFormat,"NC_SHORT"))
        xtype = NC_SHORT;
      else if (!strcasecmp(var->cFormat,"NC_INT"))
        xtype = NC_INT;
      else nl_error(4, "Unexpected unknown cFormat: '%s'", var->cFormat);
      nc_err = nc_def_var(ncid, var->label, xtype, num_dims,
        dimids, &var->var_id);
      if (nc_err != NC_NOERR)
        nl_error(3, "Error defining variable %s", var->label);
      var->chk_attr("units",
        nc_put_att_text(ncid, var->var_id, "units",
          strlen(var->units), var->units));
      { float dmf = (float)var->frequency;
        var->chk_attr("frequency",
          nc_put_att_float(ncid, var->var_id, "frequency",
            NC_FLOAT, 1, &dmf));
      }
      var->chk_attr("cal_coef",
        nc_put_att_float(ncid, var->var_id, "cal_coef", NC_FLOAT,
          var->MAXCALPWR, var->coef));
      var->chk_attr("scale_factor",
        nc_put_att_float(ncid, var->var_id, "scale_factor", NC_FLOAT,
          1, &var->scaleFactor));
      var->chk_attr("add_offset",
        nc_put_att_float(ncid, var->var_id, "add_offset", NC_FLOAT,
          1, &var->addOffset));
      var->chk_attr("valid_min",
        nc_put_att_float(ncid, var->var_id, "valid_min", NC_FLOAT,
          1, &var->min));
      var->chk_attr("valid_max",
        nc_put_att_float(ncid, var->var_id, "valid_max", NC_FLOAT,
          1, &var->max));
      var->chk_attr("long_name",
        nc_put_att_text(ncid, var->var_id, "long_name",
          strlen(var->longName), var->longName));
    }
  }

  if (nc_enddef(ncid) != NC_NOERR)
    nl_error(3, "Error leaving define mode");
}

void BS2cdf::nc_close() {
  if (opened) {
    if (::nc_close(ncid) != NC_NOERR)
      nl_error(2, "Error closing NetCDF file");
    opened = false;
  }
}

void BS2cdf::Parse_Record(const unsigned char *rec) {
  const unsigned char *SPAN_rec = &rec[0];
  const unsigned char *BAT_new = &rec[BAT_offset];
  bool SPAN_missing = SPAN_rec[0] != 0xAA;
  bool BAT_missing = BAT_new[0] != 0xF8;
  if (SPAN_missing) SPAN_rec = 0;
  if (BAT_missing) BAT_new = 0;
  if (BAT_missing && SPAN_missing) {
    nl_error(2, "Empty record");
    return;
  }
  if (BAT_saved) {
    Parse_Rec(SPAN_rec, &BAT_rec[0], 1);
    if (BAT_new) {
      memcpy(&BAT_rec[0], BAT_new, BAT_nb_rec);
    } else {
      BAT_saved = false;
    }
  } else if (SPAN_rec) {
    Parse_Rec(SPAN_rec, BAT_new, 0);
  } else {
    nl_assert(BAT_new);
    memcpy(&BAT_rec[0], BAT_new, BAT_nb_rec);
    BAT_saved = true;
  }
}

void BS2cdf::Parse_Rec(const unsigned char *SPAN_rec,
              const unsigned char *BAT_rec, int shifted) {
  // First, check to see if we have SPAN data
  // and/or BAT data. Ultimately will drop
  // the record unless we have both, but for
  // certain diagnostic purposes, looking at
  // one or the other might be interesting.
  if (!all_recs && (!SPAN_rec || !BAT_rec))
    return;
  if (all_recs) {
    if (++cur_rec == 50) {
      ++scan;
      cur_rec = 0;
    }
  } else {
    unsigned long msecs;
    unsigned long itime;
    int old_rec;
    
    memcpy((char *)&msecs, &SPAN_rec[8], sizeof(unsigned long));
    itime = msecs/1000;
    if (itime != cur_time) {
      if (cur_rec >= 0) ++scan;
      cur_time = itime;
      cur_rec = -1;
    }
    old_rec = cur_rec;
    cur_rec = (msecs%1000)/20;
    if (cur_rec == old_rec) {
      nl_error(1, "Rec[%lu][%d] repeated", scan, cur_rec);
      return;
    }
  }
  if (cur_rec >= 50) {
    nl_error(1, "%d records for second %lu", cur_rec+1, cur_time);
    return;
  }
  index[0] = scan;
  index[1] = cur_rec;
  { std::vector<BS2Cchan *>::iterator pos;
    for (pos = chan.begin(); pos < chan.end(); ++pos) {
      BS2Cchan *var = *pos;
      switch (var->device) {
        case 20:
          if (BAT_rec)
            Parse_BAT_data(var, BAT_rec);
          break;
        case 14:
          if (SPAN_rec)
            Parse_SPAN_data(var, SPAN_rec, shifted);
          break;
        default: break;
      }
    }
  }
}

void BS2cdf::Parse_BAT_data(BS2Cchan *var, const unsigned char *rec) {
  int offset = 3+2*var->physicalChannel;
  short val = (rec[offset]<<8) + rec[offset+1];
  if (var->cFormat_code != NC_SHORT)
    nl_error(3, "Unexpected format '%s' for BAT Channel", var->cFormat);
  int status = nc_put_var1_short(ncid, var->var_id, index, &val);
  if (status != NC_NOERR)
    nl_error(3, "Error nc_put_var1_short(%s[%d,%d] <= %u): %d",
      var->label, index[0], index[1], val, status);
}

void BS2cdf::Parse_SPAN_data(BS2Cchan *var, const unsigned char *rec,
          int shifted) {
  enum raw_type_t { rt_double, rt_ushort, rt_long, rt_special };
  raw_type_t raw_type;
  double dval, scaled;
  short sval;
  int ival, offset, status;
  unsigned short usval;
  long lval;

  switch (var->physicalChannel) {
    case 0: raw_type = rt_double; offset = 24; break; // Lat
    case 1: raw_type = rt_double; offset = 32; break; // Lon
    case 2: raw_type = rt_double; offset = 40; break; // Alt == Ellip. Ht
    case 3: raw_type = rt_double; offset = 48; break; // Su == N_Velocity
    case 4: raw_type = rt_double; offset = 56; break; // Sv == E_Velocity
    case 5: raw_type = rt_double; offset = 64; break; // Sw == Up_Velocity
    case 6: raw_type = rt_double; offset = 80; break; // Pitch
    case 7: raw_type = rt_double; offset = 72; break; // Roll
    case 8: raw_type = rt_double; offset = 88; break; // Hdg == Azimuth
    case 9: raw_type = rt_ushort; offset = 96; break; // INS_Status
    case 10: raw_type = rt_double; offset = 16; break; // Time == GPS_secs
    case 11: raw_type = rt_ushort; offset = 6; break; // GPS_week
    case 12: raw_type = rt_special; offset = 0; break; // Shifted
    default:
      nl_error(3, "Invalid SPAN channel number for var %s",
        var->physicalChannel, var->label);
  }
  switch (raw_type) {
    case rt_double:
      memcpy((unsigned char *)&dval, &rec[offset], sizeof(double));
      break;
    case rt_ushort:
      memcpy((unsigned char *)&usval, &rec[offset], sizeof(unsigned short));
      dval = usval;
      break;
    case rt_long:
      memcpy((unsigned char *)&lval, &rec[offset], sizeof(long));
      dval = lval;
      break;
    case rt_special:
      dval = shifted;
      break;
  }
  scaled = (dval - var->addOffset)/var->scaleFactor;
  switch (var->cFormat_code) {
    case NC_SHORT:
      if (scaled < SHRT_MIN || scaled > SHRT_MAX)
        nl_error(1, "Scaled value of var %s exceeds NC_SHORT range",
            var->label);
      sval = scaled;
      status = nc_put_var1_short(ncid, var->var_id, index, &sval);
      break;
    case NC_INT:
      if (scaled < INT_MIN || scaled > INT_MAX)
        nl_error(1, "Scaled value of var %s exceeds NC_INT range", var->label);
      ival = scaled;
      status = nc_put_var1_int(ncid, var->var_id, index, &ival);
      break;
    default:
      nl_error(3, "Unexpected cFormat type for var %s in Parse_SPAN_data()",
          var->label );
  }
  if (status != NC_NOERR) {
    nl_error(3, "Error writing value for var %s: %d", var->label, status);
  }
}

/**
 * Reads the file and writes data to NetCDF, then closes the file.
 * @return non-zero on read error without reporting.
 */
int BS2cdf::Read_File(FILE *fp) {
  int rv = 0;
  for (;;) {
    int nr, i;
    nr = fread(&ibuf[0][0], nb_rec, n_rec, fp);
    for (i = 0; i < nr; ++i) {
      Parse_Record(&ibuf[i][0]);
    }
    if (feof(fp)) break;
    else if (ferror(fp)) {
      rv = 1;
      break;
    }
  }
  fclose(fp);
  return rv;
}

int main(int argc, char **argv) {
  FILE *fp;
  mlf_def_t *mlf;
  BS2cdf BS2C;
  oui_init_options(argc, argv);
  BS2C.nc_setup(data_path, setup_path);
  mlf = BS2C.mlf_init(data_path);
  nl_error(0, "Start");
  while (mlf->index < BS2C.last_idx) {
    fp = mlf_next_file(mlf);
    if (fp != 0) {
      if (BS2C.Read_File(fp))
        nl_error(2, "Error reading file %s", mlf->fpath);
    }
  }
  BS2C.nc_close();
  nl_error(0, "Terminating");
  return 0;
}
