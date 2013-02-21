/* Data recovery for BAT_SPAN
   Read through file one block at a time
   Search through block for SPAN or BAT signature within the first 278 bytes
   If found, find SPAN record, isolate msecs record and check to see if it
   is in the range 3.94e8 to 4.1e8. If so, count it and record:
     serial number
     disk block number
     starting offset
     msecs
*/
#include <string.h>
#include "BAT_SPAN_int.h"
#include "nortlib.h"

int find_string(const char *src, const char *pat, int n) {
  int i;
  for (i = 0; i < n - (int)strlen(pat); ++i) {
    const char *s = src+i;
    const char *p = pat;
    while (*p != '\0' && *p == *s) {
      ++p;
      ++s;
    }
    if (*p == '\0') return i;
  }
  return -1;
}

int main(int argc, char **argv) {
  FILE *ifp;
  unsigned disk_block_num = 0;
  unsigned bat_span_block_num = 0;
  if (argc > 1) {
    ifp = fopen64(argv[1], "r");
    if (ifp == 0)
      nl_error(3, "Unable to open input file %s", argv[1]);
  } else ifp = stdin;
  for (disk_block_num = 0;; ++disk_block_num) {
    char block[512];
    int offset;
    const char *pat = "\xAA\x44\x13\x58\xFC\x01";
    int nb = fread(block, 1, 512, ifp);
    if (nb < 512) break;
    offset = find_string(block, pat, 512);
    if (offset >= 0) {
      struct INSPVASB *PVA = (struct INSPVASB *)(&block[offset]);
      if (PVA->GPS_msecs > 394000000L && PVA->GPS_msecs < 410000000L) {
      // if (PVA->GPS_msecs > 222000000L && PVA->GPS_msecs < 227000000L) {
        printf("%5u %7u %3d %9ld\n", ++bat_span_block_num, disk_block_num,
          offset, PVA->GPS_msecs);
      }
    }
  }
  return 0;
}
