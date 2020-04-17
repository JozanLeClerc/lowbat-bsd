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
** n: notify
*/

int
main(void)
{
	int8_t	status;
	int8_t	percent;

	if ((status = jo_f_status()) == -2) {
		return (JO_RET_RD_FAILED);
	}
	if ((percent = jo_f_percent()) == -3) {
		printf("failed\n");
		return (JO_RET_RD_FAILED);
	}
	printf("status: %hhd, %hhd%%\n", status, percent);
	return (JO_RET_FINE);
}
