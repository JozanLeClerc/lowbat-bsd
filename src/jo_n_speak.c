/****************************************************************************************/
/*                                                                                      */
/*  File     : jo_n_speak.c                                               /_________/   */
/*  Author   : Joe                                                              |       */
/*  Date     : 04/2020                                                          |       */
/*  Info     : Uses espeak lib to speak                                         |       */
/*                                                                      /       |       */
/*                                                                      \       /       */
/*                                                                       \_____/        */
/*                                                                                      */
/****************************************************************************************/

#include <jo_n_speak.h>

void
jo_n_speak(const char *msg)
{
	espeak_Initialize(AUDIO_OUTPUT_PLAYBACK, 0, NULL, 0);
	espeak_Synth(msg,
				 strlen(msg),
				 0,
				 POS_CHARACTER,
				 0,
				 espeakCHARS_UTF8 | espeakENDPAUSE,
				 NULL,
				 NULL);
	espeak_Synchronize();
	espeak_Terminate();
}
