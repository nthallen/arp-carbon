/* BS2cdf.cc */
#include <stdarg.h>
#include <ctype.h>
#include "BS2cdf.h"

const char *data_path;

unsigned char BS2cdf::ibuf[BS2cdf::n_rec][BS2cdf::nb_rec];

BS2cdf::BS2cdf() {
  ncid = -1;
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

void BS2cdf::nc_setup() {
}

void BS2cdf::nc_close() {
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
  BS2C.nc_setup();
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
