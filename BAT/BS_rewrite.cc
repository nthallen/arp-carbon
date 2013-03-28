/* BS_rewrite.cc
 * Read:
 *   mlf_index  mlf_block  disk_block
 * Disk blocks start at zero, hence the data starts at byte disk_block*512
 * If the following block is missing, the partial record at the end of
 * the current block should be zeroed out and the following block should
 * be written as all zeros. The last block in each file needs to be
 * truncated to (500*nb_rec)%512 = 380 bytes.
 * There are ceil(500*nb_rec/512) = 136 blocks in each file (except
 * possibly the last file.
 */
#include <string.h>
#include "BAT_SPAN_int.h"
#include "nortlib.h"
#include "nl_assert.h"
#include "mlf.h"

#ifdef __USAGE
%C <index_file> <disk_image>
Output will be written to BAT_SPAN directory
#endif

int main(int argc, char **argv) {
  FILE *idx, *img, *ofp = NULL;
  mlf_def_t *mlf;
  int cur_mlf_index = 0, cur_mlf_block = 0;

  if (argc < 3) nl_error(3, "BS_rewrite <index_file> <disk_image>");
  idx = fopen(argv[1],"r");
  if (idx == 0) nl_error(3, "Unable to open index file '%s'", argv[1]);
  img = fopen64(argv[2],"rb");
  if (img == 0) nl_error(3, "Unable to open disk image file '%s'", argv[2]);
  mlf = mlf_init(3, 60, 1, "BAT_SPAN", "dat", NULL);
  for (;;) {
    int mlf_index, mlf_block, disk_block, GPS_msecs;
    int n = fscanf(idx, "%d %d %d %d", &mlf_index, &mlf_block, &disk_block, &GPS_msecs);
    char block[512];

    nl_assert(n < 4 || (mlf_block != cur_mlf_block && mlf_block >= 1 && mlf_block <= 136));
    if (n < 4 || mlf_block < cur_mlf_block) {
      /* Need to close out cur_mlf_block and close the file */
      nl_assert(ofp != 0);
      if (cur_mlf_block == 136) {
        fwrite(block, 1, 380, ofp);
      } else {
        fwrite(block, 1, 512, ofp);
        nl_error(1, "Closing file %d at block %d", cur_mlf_index, cur_mlf_block);
      }
      fclose(ofp);
      ofp = NULL;
      if (n<4) break;
    } else if (mlf_block > cur_mlf_block+1) {
      /* Zero out last partial record */
      nl_assert(ofp != 0);
      int zeros = (cur_mlf_block*512)%139;
      nl_assert(zeros > 0 && zeros < 512);
      memset(&block[512-zeros], 0, zeros);
      fwrite(block, 1, 512, ofp);
      memset(block, 0, 512);
      while (cur_mlf_block+1 < mlf_block) {
        fwrite(block, 1, 512, ofp);
        ++cur_mlf_block;
      }
    } else if (ofp) {
      fwrite(block, 1, 512, ofp);
    }
    cur_mlf_block = mlf_block;
    if (mlf_index != cur_mlf_index) {
      nl_assert(mlf_index == cur_mlf_index+1);
      if (ofp) {
        fclose(ofp);
      }
      ofp = mlf_next_file(mlf);
      cur_mlf_index = mlf_index;
    }
    fseeko64(img, ((off64_t)disk_block)*512, SEEK_SET);
    fread(block, 1, 512, img);
  }
  fclose(idx);
  fclose(img);
  return 0;
}
