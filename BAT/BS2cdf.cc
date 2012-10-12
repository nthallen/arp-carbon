/* BS2cdf.cc */
#include "BS2cdf.h"

const char *mlf_config;

unsigned char BS2cdf::ibuf[BS2cdf::n_rec][BS2cdf::nb_rec];

BS2cdf::BS2cdf() {
  ncid = -1;
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
  mlf = mlf_init(3, 60, 0, "BAT_SPAN", "dat", mlf_config);
  BS2C.nc_setup();
  nl_error(0, "Start");
  for (;;) {
    fp = mlf_next_file(mlf);
    if (fp == 0) break;
    if (BS2C.Read_File(fp))
      nl_error(2, "Error reading file %s", mlf->fpath);
  }
  BS2C.nc_close();
  nl_error(0, "Terminating");
  return 0;
}
