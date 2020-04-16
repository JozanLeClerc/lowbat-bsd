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

#include <inttypes.h>

enum
{
	JO_RET_FINE,
	JO_RET_RD_FAILED
};

int8_t	jo_f_status(void);

#endif
