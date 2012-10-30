#ifndef BS2CDF_H_INCLUDED
#define BS2CDF_H_INCLUDED

#include <netcdf.h>
#include "nortlib.h"
#include "oui.h"
#include "mlf.h"

extern const char *data_path;
extern const char *setup_path;

#ifdef __cplusplus

#include <dequeue>

class BS2Cchan {
  public:
    BS2Cchan(const char *line, const char *filename, int line_num);
    ~BS2Cchan();
    bool valid;
    char label[12];
    short device
    short phsicalChannel;
    short frequency;
    char units[12];
    short cal_pwr;
    float coef[5];
    float min;
    float max;
    char cFormat[9];
    float scaleFactor;
    float addOffset;
    char longName[100];
  private:
    int parse_str(char *ibuf, int len, const char *strname, int ws_ok = 0);
    int chk_sscanf(int bad_ret, int nc, const char *what);
    const char *cfg;
    const char *file;
    unsigned line_num;
    int cp;
};

class BS2cdf {
  public:
    BS2cdf();
    ~BS2cdf();
    mlf_def_t *mlf_init(const char *data_path);
    void nc_setup();
    int Read_File(FILE *fp);
    void nc_close();
    unsigned long last_idx;
  private:
    void Parse_Record(unsigned char *rec);
    const char *back_tick(const char *fmt, ...);
    bool opened;
    int ncid, dimids[2];
    unsigned line_num;
    std::vector<BS2Cchan *> chan;
    static const int SPAN_nb_rec = 104;
    static const int BAT_nb_rec = 35;
    static const int nb_rec = SPAN_nb_rec + BAT_nb_rec;
    static const int n_rec = 500; // defined in BSlogger.cc
    static unsigned char ibuf[n_rec][nb_rec];
};

#endif 

#endif
