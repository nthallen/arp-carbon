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
#include "BAT_SPAN_int.h"

int main(int argc, char **argv) {
  FILE *ifp;
  unsigned disk_block_num = 0;
  unsigned bat_span_block_num = 0;
  if (argc > 1) {
    ifp = fopen(argv[1], "r");
    if (ifp == 0)
      nl_error(3, "Unable to open input file %s", argv[1]);
  } else ifp = stdin;
  for (disk_block_num = 0;; ++disk_block_num) {
    unsigned char block[512], *pkt;
    int nb = fread(block, 1, 512, ifp);
    if (nb < 512) break;
    pkt = strstr(block, "\xAA\x44\x13\x58\x1C")
    if (pkt) {
      struct INSPVASB *PVA = pkt;
      if (PVA.GPS_msecs > 394000000L && PVA.GPS_msecs < 410000000L) {
        unsigned offset = pkt - block;
        printf("%5u %7u %3u %9u\n", ++bat_span_block_num, disk_block_num,
          offset, PVA.GPS_msecs);
      }
    }
  }
  return 0;
}
