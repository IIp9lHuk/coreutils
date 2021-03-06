#include "license.h"

#ifdef __TINYC__
# include <tcclib.h>
#else
# include <stdlib.h>
#endif

#include <string.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	int s = argc == 1 ? 1 : 0;
	char *out = argc == 1 ? "y" : malloc(sizeof(char));

	while (--argc > 0 && *++argv) {
		s += sizeof(*argv);
		out = realloc(out, sizeof(char) * s);
		out = strcat(out, *argv);
		if (argc > 1)
			out = strcat(out, " ");
	}

	while (1)
		s = write(1, out, strlen(out));

	return (s == -1) ? 1 : 0;
}
