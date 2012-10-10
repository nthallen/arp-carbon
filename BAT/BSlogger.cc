/* BSlogger.cc */
#include <errno.h>
#include "oui.h"
#include "nortlib.h"
#include "mlf.h"
#include "BAT_SPAN_int.h"

const char *mlf_config;

const int recs_per_file = 50*10;
unsigned char ibuf[recs_per_file][BSlogger::rec_size];

int main(int argc, char **argv) {
  mlf_def_t *mlf;
  FILE *fp = 0;
  bool done = false;
  int recs_recd = 0;
  int recs_writ = 0;
  oui_init_options(argc, argv);
  mlf = mlf_init(3, 60, 1, "BAT_SPAN", "dat", mlf_config);
  nl_error(0, "Start");
  while (!done) {
    int nr = fread(&ibuf[recs_recd][0], BSlogger::rec_size,
                recs_per_file - recs_recd, stdin);
    if (nr > 0 && ibuf[recs_recd][0] != 0xAA &&
                  ibuf[recs_recd][0] != '\0')
      nl_error(1, "Invalid data from BAT_SPAN in record %d", recs_recd);
    recs_recd += nr;
    if (feof(stdin)) done = true;
    else if (ferror(stdin))
      nl_error(3, "Error %d reading from stdin", errno);
    if (recs_recd > recs_writ) {
      if (fp == 0) fp = mlf_next_file(mlf);
      nr = fwrite(&ibuf[recs_writ][0], BSlogger::rec_size,
              recs_recd - recs_writ, fp);
      recs_writ += nr;
      if (recs_writ < recs_recd)
        nl_error(3, "Error %d writing to %s", mlf->fpath);
      if (recs_writ == recs_per_file) {
        fclose(fp);
        fp = 0;
        recs_writ = recs_recd = 0;
      }
    }
  }
  nl_error(0, "Terminating");
}
