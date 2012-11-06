#ifndef BS2CDF_H_INCLUDED
#define BS2CDF_H_INCLUDED

#include <netcdf.h>
#include "nortlib.h"
#include "oui.h"
#include "mlf.h"

extern const char *data_path;
extern const char *setup_path;
extern bool all_recs;

#ifdef __cplusplus

#include <vector>

class BS2Cchan {
  public:
    BS2Cchan(const char *line, const char *filename, int line_num);
    ~BS2Cchan();
    void chk_attr(const char *attr, int nc_err);
    bool valid;
    char label[12];
    short device;
    short phsicalChannel;
    short frequency;
    char units[12];
    static const unsigned MAXCALPWR = 5;
    short cal_pwr;
    float coef[MAXCALPWR];
    float min;
    float max;
    char cFormat[9];
    int cFormat_code;
    float scaleFactor;
    float addOffset;
    char longName[100];
    int var_id;
  private:
    int parse_str(char *ibuf, int len, const char *strname, int ws_ok = 0);
    int chk_sscanf(int bad_ret, int nc, const char *what);
    const char *cfg;
    const char *file;
    unsigned line_num;
    int cp;
};

class BS2Cdim {
  public:
    BS2Cdim(short freq);
    short frequency;
    int dim_id;
};

class BS2cdf {
  public:
    BS2cdf();
    ~BS2cdf();
    mlf_def_t *mlf_init(const char *data_path);
    void nc_setup(const char *data_path, const char *setup_path);
    int Read_File(FILE *fp);
    void nc_close();
    unsigned long last_idx;
  private:
    void Parse_Record(const unsigned char *rec);
    void Parse_BAT_data(BS2Cchan *var, const unsigned char *rec);
    const char *back_tick(const char *fmt, ...);
    bool opened;
    int ncid, scan_dimid;
    unsigned line_num;
    std::vector<BS2Cchan *> chan;
    std::vector<BS2Cdim> dims;
    unsigned long cur_time;
    int scan, cur_rec;
    int index[2];
    bool haveGPStime;
    static const int SPAN_nb_rec = 104;
    static const int SPAN_offset = 0;
    static const int BAT_nb_rec = 35;
    static const int BAT_offset = SPAN_nb_rec;
    static const int nb_rec = SPAN_nb_rec + BAT_nb_rec;
    static const int n_rec = 500; // defined in BSlogger.cc
    static unsigned char ibuf[n_rec][nb_rec];
};

#endif 

#endif
