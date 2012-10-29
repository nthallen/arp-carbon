#ifndef BS2CDF_H_INCLUDED
#define BS2CDF_H_INCLUDED

#include <netcdf.h>
#include "nortlib.h"
#include "oui.h"
#include "mlf.h"

extern const char *data_path;

#ifdef __cplusplus

class BS2cdf {
  public:
    BS2cdf();
    mlf_def_t *mlf_init(const char *data_path);
    void nc_setup();
    int Read_File(FILE *fp);
    void nc_close();
  private:
    void Parse_Record(unsigned char *rec);
    void back_tick(const char *fmt, ...);
    static const int SPAN_nb_rec = 104;
    static const int BAT_nb_rec = 35;
    static const int nb_rec = SPAN_nb_rec + BAT_nb_rec;
    static const int n_rec = 500; // defined in BSlogger.cc
    static unsigned char ibuf[n_rec][nb_rec];
    int ncid;
};

#endif 

#endif
