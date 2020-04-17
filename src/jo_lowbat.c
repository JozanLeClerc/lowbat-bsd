/****************************************************************************************/
/*                                                                                      */
/*  File     : jo_lowbat.c                                                /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : The main                                                         |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

#include <jo_lowbat.h>
#include <libnotify/notify.h>

/*
** Files prefixes
** --------------
** f: fetch
** n: notify
** r: run
*/

int
main(
	int			argc,
	char	*argv[]
	)
{
	return (jo_r_lowbat(argc, argv));
}
