/****************************************************************************************/
/*                                                                                      */
/*  File     : jo_lowbat.h                                                /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : The general header                                               |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

#ifndef JO_LOWBAT_H
#define JO_LOWBAT_H

#include <jo_lowbat.h>
#include <jo_n_speak.h>
#include <jo_n_notify.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

enum
{
	JO_RET_FINE,
	JO_RET_RD_FAILED,
	JO_RET_ESPEAK_FAILED
};

int8_t	jo_r_lowbat(
			int,
			const char**
			);
int8_t	jo_f_status(void);
int8_t	jo_f_percent(void);

#endif
