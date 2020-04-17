/****************************************************************************************/
/*                                                                                      */
/*  File     : jo_n_notify.c                                              /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Uses libnotify lib to notify                                     |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

#include <jo_n_notify.h>

void
jo_n_notify(
	const char		head[],
	const char		body[],
	NotifyUrgency	u,
	int32_t			t
	)
{
	NotifyNotification *n;

	notify_init("lowbat");
	n = notify_notification_new(head, body, NULL);
	notify_notification_set_urgency(n, u);
	notify_notification_set_timeout(n, t);
	notify_notification_show(n, NULL);
	notify_uninit();
	n = NULL;
}
