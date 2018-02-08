#include <stdio.h>

size_t fwrite$UNIX2003(const void *a, size_t b, size_t c, FILE *d)
{
	return fwrite(a, b, c, d);
}

size_t fputs$UNIX2003(char *a, FILE* fp)
{
	return fputs(a, fp);
}
