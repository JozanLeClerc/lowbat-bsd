/****************************************************************************************/
/*                                                                                      */
/*  File     : n_speak.h                                                  /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Use espeak lib to speak                                          |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

#ifndef JO_N_SPEAK_H
#define JO_N_SPEAK_H

#include <espeak/speak_lib.h>
#include <string.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>
#include <unistd.h>

enum
{
	JO_RET_FINE,
	JO_RET_RD_FAILED,
	JO_RET_ESPEAK_FAILED
};

#define JO_ESPEAK_VOICE "English"

void	n_speak(const char *);

#endif
