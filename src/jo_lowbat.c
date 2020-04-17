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

int
main(
	int			argc,
	const char	*argv[]
	)
{
	return (jo_r_lowbat(argc, argv));
}
