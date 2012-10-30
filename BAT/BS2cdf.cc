/* BS2cdf.cc */
#include <stdarg.h>
#include <stdlib.h>
#include <ctype.h>
#include <strings.h>
#include <time.h>
#include "BS2cdf.h"

const char *data_path;
const char *setup_path;

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
  n = sscanf(&cfg[cp], "%hd%hd%hd%n", &device, &phsicalChannel, &frequency, &nc);
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
  if ((strcasecmp(cFormat, "NC_CHAR")) &&
      (strcasecmp(cFormat, "NC_SHORT")) &&
      (strcasecmp(cFormat, "NC_INT")))
    nl_error(2, "%s:%d Invalid cFormat for %s: '%s'",
        file, line_num, label, cFormat);
  n = sscanf(&cfg[cp], "%f%f%n", &scaleFactor, &addOffset, &nc);
  if (chk_sscanf(n != 2, nc, "scaleFactor or addOffset"))
    return;
  if (parse_str(&longName[0], sizeof(longName), "longName")) return;
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
  nc_err = nc_def_dim(ncid, "scan", NC_UNLIMITED, &dimids[0]);
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
    for (pos = chan.begin(); pos < chan.end(); ++pos) {
      int num_dims = ((*pos)->frequency > 1) ? 2 : 1;
      // find dimension...
    }
  }
      // Add definitions to ncid
      /*  setup_template.txt variable columns:
          label  string (var name)
          device  short integer
          physicalChannel short integer
          frequency short integer
          units string
          cal_pwr short integer (number of coef for polynomial fit)
          coef[0 .. cal_pwr-1] float
          min float min expected engineering value (should actually be min expected raw value)
          max float max expected engineering value (")
          cFormat string netcdf data type
          scaleFactor float
          addOffset float
          longName string */

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

void BS2cdf::Parse_Record(unsigned char *rec) {
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
  while (mlf->index <= BS2C.last_idx) {
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
