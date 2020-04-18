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
	espeak_ERROR	err;
	int32_t			samplerate;

	samplerate = espeak_Initialize
		(AUDIO_OUTPUT_PLAYBACK,
		 500,
		 NULL,
		 0);
	if (samplerate == -1) {
		dprintf(2, "Failed to initialize espeak\n");
		exit(JO_RET_ESPEAK_FAILED);
	}
	espeak_SetVoiceByName(JO_ESPEAK_VOICE);
	err = espeak_Synth
		(msg,
		 strlen(msg) + 1,
		 0,
		 POS_CHARACTER,
		 0,
		 espeakCHARS_AUTO | espeakENDPAUSE,
		 NULL,
		 NULL);
	if (err != EE_OK) {
		dprintf(STDERR_FILENO, "espeak synth error\n");
	}
	espeak_Synchronize();
	espeak_Terminate();
}
