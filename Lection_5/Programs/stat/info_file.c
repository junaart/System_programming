#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>
int main (int argc, char *argv[])
{
   struct stat sb;
   int ret;
   if (argc < 2) {
     printf("Error count args\n");
     return 1;
   }
   ret = stat (argv[1], &sb);
   if (ret) {
     perror ("stat");
     return 1;
   }
	printf ("st_dev: %ld, size st_dev: %lu\n", sb.st_dev, sizeof(dev_t));
        printf ("st_ino: %ld, size st_ino: %lu\n", sb.st_ino, sizeof(ino_t));
	printf ("st_mode: %ld, size st_mode: %lu\n", sb.st_mode, sizeof(mode_t));
	printf ("st_nlink: %ld, size st_nlink: %lu\n", sb.st_nlink, sizeof(nlink_t));
	printf ("st_uid: %ld, size st_uid: %lu\n", sb.st_uid, sizeof(uid_t));
	printf ("st_gid: %ld, size st_gid: %lu\n", sb.st_gid, sizeof(gid_t));
	printf ("st_rdev: %ld, size st_rdev: %lu\n", sb.st_rdev, sizeof(dev_t));
	printf ("st_size: %ld, size st_size: %lu\n", sb.st_size, sizeof(off_t));
	printf ("st_blksize: %ld, size st_blksize: %lu\n", sb.st_blksize, sizeof(blksize_t));
	printf ("st_blocks: %ld, size st_blocks: %lu\n", sb.st_blocks, sizeof(blkcnt_t));
	printf ("st_atime: %ld, size  st_atime: %lu\n", sb.st_atime, sizeof(time_t));
	printf ("st_mtime: %ld, size  st_mtime: %lu\n", sb.st_mtime, sizeof(time_t));
        printf ("st_ctime: %ld, size  st_ctime: %lu\n", sb.st_ctime, sizeof(time_t));
	
   return 0;
}
