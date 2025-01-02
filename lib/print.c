#include "print.h"
#include "string.h"

void	print(char *str)
{
	write(STDERR_FILENO, str, strlen(str));
}
