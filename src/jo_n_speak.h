/****************************************************************************************/
/*                                                                                      */
/*  File     : jo_n_speak.h                                               /_________/   */
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

#include <jo_lowbat.h>
#include <espeak/speak_lib.h>
#include <string.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>
#include <unistd.h>

#define JO_ESPEAK_VOICE "English"

void	jo_n_speak(const char *);

#endif
