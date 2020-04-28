/****************************************************************************************/
/*                                                                                      */
/*  File     : n_notify.h                                                 /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Uses libnotify lib to notify                                     |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

#ifndef JO_N_NOTIFY_H
#define JO_N_NOTIFY_H

#include <libnotify/notify.h>
#include <stddef.h>
#include <stdint.h>

#define	JO_LOWBAT "lowbat"

void	n_notify(
			const char[],
			const char[],
			NotifyUrgency,	
			int32_t
			);

#endif
