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
*/

int
main(
	int argc,
	const char *argv[]
	)
{
	int8_t	status;
	int8_t	percent;

	(void)argc;
	(void)argv;
	if ((status = jo_f_status()) == -2) {
		return (JO_RET_RD_FAILED);
	}
	if ((percent = jo_f_percent()) == -3) {
		return (JO_RET_RD_FAILED);
	}
	printf("status: %hhd, %hhd%%\n", status, percent);
	/* NOTIFY-SEND */
	jo_n_notify("VEGA: Yo", "Welcome", NOTIFY_URGENCY_LOW, 5000);
	jo_n_speak("Heya!");
	return (JO_RET_FINE);
}
