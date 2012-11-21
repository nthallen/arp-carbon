%{
  #ifdef SERVER
  #include <ctype.h>

  void lk204_set_led(int led, int color) {
    sbwr(0x1102, 0x1FE);
    sbwr(0x1102, (color&1) ? 0x157 : 0x156);
    sbwr(0x1102, 0x100 + 2*led);
    sbwr(0x1102, 0x1FE);
    sbwr(0x1102, (color&2) ? 0x157 : 0x156);
    sbwr(0x1102, 2*led + 1);
  }
  void lk204_set_gpo(int gpo, int on) {
    if (gpo >= 0 && gpo < 8) {
      sbwr(0x1102, 0x1FE);
      sbwr(0x1102, on ? 0x157 : 0x156);
      sbwr(0x1102, gpo);
    }
  }
  
  unsigned xdig2num(unsigned char dig) {
    if (isdigit(dig)) return dig - '0';
    if (isxdigit(dig)) return tolower(dig) - 'a' + 10;
    return 0;
  }
  
  void lk204_seq(const unsigned char *str) {
    while (*str != '\0') {
      unsigned short val = *str++;
      if (val == '\n' || val == '\r') break;
      if (val == '\\') {
        switch (*str) {
          case '\n':
          case '\r':
          case 0:
            return;
          case 'r': val = '\r'; break;
          case 'n': val = '\n'; break;
          case 'x':
            val = 0;
            str++;
            if (isxdigit(*str)) {
              val = xdig2num(*str++);
              if (isxdigit(*str)) {
                val = val*16 + xdig2num(*str++);
              }
            }
            break;
          default: val = *str++; break;
        }
      }
      if (*str != '\0') val |= 0x100;
      sbwr(0x1102, val);
    }
  }
  #endif
%}
&command
  : Panel Purge LED &on_off * { sbwr( 0x1104, ($4<<7) | 0x10); }
  : Panel Data LED &on_off * { sbwr( 0x1104, ($4<<7) | 0x20); }
  : Panel &lk204_led &lk204_color * { lk204_set_led($2, $3); }
  : Panel Set GPO %d &on_off * { lk204_set_gpo($4, $5); }
  : Panel Clear Screen * { lk204_seq( (const unsigned char*)"\xFE\x58" ); }
  : Panel Display Text %s { lk204_seq((const unsigned char*)$4); }
  ;
&lk204_led <int>
  : Top LED { $0 = 0; }
  : Middle LED { $0 = 1; }
  : Bottom LED { $0 = 2; }
  ;
&lk204_color <int>
  : Yellow { $0 = 0; }
  : Green { $0 = 1; }
  : Red { $0 = 2; }
  : Off { $0 = 3; }
  ;
