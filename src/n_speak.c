/*
 * ========================
 * =====    ===============
 * ======  ================
 * ======  ================
 * ======  ====   ====   ==
 * ======  ===     ==  =  =
 * ======  ===  =  ==     =
 * =  ===  ===  =  ==  ====
 * =  ===  ===  =  ==  =  =
 * ==     =====   ====   ==
 * ========================
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2020-2021 Joe
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the organization nor the
 *    names of its contributors may be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY JOE ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL JOE BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * lowbat: src/n_speak.c
 * Wed Feb 10 19:22:45 CET 2021
 * Joe
 */

#include "n_speak.h"

void
n_speak(const char *msg)
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
