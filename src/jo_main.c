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
	int8_t	status;

	if ((status = jo_f_status()) < 0) {
		return (JO_RET_RD_FAILED);
	}
	printf("status: %d\n", status);
	return (JO_RET_FINE);
}
