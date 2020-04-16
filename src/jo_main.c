/****************************************************************************************/
/*                                                                                      */
/*  File     : jo_main.c                                                  /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : The main                                                         |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

#include <jo_main.h>

/*
** Files prefixes
** --------------
** f: fetch
*/

int
main(void)
{
	char	*status;

	if (!(status = jo_f_status())) {
		return (JO_RET_RD_FAILED);
	}
	printf("status: %s\n", status);
	free(status);
	status = NULL;
	return (JO_RET_FINE);
}
