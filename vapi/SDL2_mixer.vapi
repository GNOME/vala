/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016-2020 SDL2 VAPI Authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Authors:
 *  Mario Daniel Ruiz Saavedra <desiderantes93@gmail.com>
 *  Gontzal Uriarte <txasatonga@gmail.com>
 *  Pedro H. Lara Campos <root@pedrohlc.com>
 */

[CCode (cheader_filename = "SDL2/SDL_mixer.h")]
namespace SDLMixer {
	[CCode (cname = "Mix_Linked_Version")]
	public static unowned SDL.Version? linked ();

	[CCode (cname = "Mix_OpenAudio")]
	public static int open (int frequency, SDL.Audio.AudioFormat format, int channels, int chunksize);

	[CCode (cname = "Mix_CloseAudio")]
	public static void close ();

	[CCode (cname = "Mix_QuerySpec")]
	public static int query (out int frequency, out SDL.Audio.AudioFormat format, out int channels);

	[CCode (cname = "Mix_SetPostMix")]
	public static void set_post_mixer (MixFunction f);

	[CCode (cname = "Mix_SetSynchroValue")]
	public static int set_synchro_value (int value);

	[CCode (cname = "Mix_GetSynchroValue")]
	public static int get_synchro_value ();

	[CCode (has_typedef = false, instance_pos = 0.9)]
	public delegate void MixFunction (uint8[] stream);
	[CCode (has_typedef = false, has_target = false)]
	public delegate void MusicFinishedCallback ();
	[CCode (has_typedef = false, has_target = false)]
	public delegate void ChannelFinishedCallback (int channel);
	[CCode (cname = "Mix_EffectFunc_t", instance_pos = 3.9)]
	public delegate void EffectCallback (int chan, void* stream, int len);
	[CCode (cname = "Mix_EffectDone_t", instance_pos = 1.9)]
	public delegate void EffectDoneCallback (int chan);

	[CCode (cname = "int", cprefix = "MIX_")]
	public enum FadeStatus {
		NO_FADING, FADING_OUT, FADING_IN
	}// FadeStatus

	[CCode (cname = "Mix_MusicType", cprefix = "MUS_")]
	public enum MusicType {
		NONE, CMD, WAV, MOD, MID, OGG, MP3, FLAC, OPUS
	}// MusicType

	[CCode (cname = "Mix_Chunk", free_function = "Mix_FreeChunk")]
	[Compact]
	public class Chunk {
		[CCode (cname = "Mix_LoadWAV_RW")]
		public Chunk.WAV_RW (SDL.RWops src, int freesrc = 0);

		[CCode (cname = "Mix_LoadWAV")]
		public Chunk.WAV (string file);

		[CCode (cname = "Mix_QuickLoad_WAV")]
		public Chunk.QuickWAV ([CCode (array_length = false)] uint8[] mem);

		[CCode (cname = "Mix_QuickLoad_RAW")]
		public Chunk.QuickRAW (uint8[] mem);

		[CCode (cname = "Mix_VolumeChunk")]
		public int volume (int num);
	}// Chunk

	[CCode (cname = "Mix_Music", free_function = "Mix_FreeMusic")]
	[Compact]
	public class Music {
		[CCode (cname = "Mix_GetMusicHookData")]
		public static void* get_hook_data ();

		[CCode (cname = "Mix_HookMusic")]
		public static void hook_mixer (MixFunction? f);

		[CCode (cname = "Mix_HookMusicFinished")]
		public static void hook_finished (MusicFinishedCallback cb);

		[CCode (cname = "Mix_FadeOutMusic")]
		public static int fade_out (int ms);

		[CCode (cname = "Mix_FadingMusic")]
		public static FadeStatus is_fading ();

		[CCode (cname = "Mix_VolumeMusic")]
		public static int volume (int num);

		[CCode (cname = "Mix_HaltMusic")]
		public static int halt ();

		[CCode (cname = "Mix_PauseMusic")]
		public static void pause ();

		[CCode (cname = "Mix_ResumeMusic")]
		public static void resume ();

		[CCode (cname = "Mix_RewindMusic")]
		public static void rewind ();

		[CCode (cname = "Mix_PausedMusic")]
		public static bool is_paused ();

		[CCode (cname = "Mix_SetMusicPosition")]
		public static int position (double position);

		[CCode (cname = "Mix_PlayingMusic")]
		public static bool is_playing ();

		[CCode (cname = "Mix_SetMusicCMD")]
		public static int set_play_command (string command);

		[CCode (cname = "Mix_LoadMUS")]
		public Music (string file);

		[CCode (cname = "Mix_LoadMUS_RW")]
		public Music.RW (SDL.RWops rw, bool freesrc);

		[CCode (cname = "Mix_GetMusicType")]
		public MusicType type ();

		[CCode (cname = "Mix_PlayMusic")]
		public int play (int loops);

		[CCode (cname = "Mix_FadeInMusicPos")]
		public int fade_in (int loops, int ms, double position = 0.0);
	}// Music

	namespace Effect {
		[CCode (cname = "Mix_RegisterEffect")]
		public static int register (int chan, [CCode (delegate_target_pos = 3.9)] EffectCallback f, [CCode (delegate_target_pos = 3.9)] EffectDoneCallback? d);

		[CCode (cname = "Mix_UnregisterEffect")]
		public static int unregister (int chan, [CCode (delegate_target = false)] EffectCallback f);

		[CCode (cname = "Mix_UnregisterAllEffects")]
		public static int unregister_all (int channel);
	}// Effect

	[CCode (cname = "int")]
	[SimpleType]
	public struct Channel: int {
		[CCode (cname = "Mix_AllocateChannels")]
		public static int allocate (int num_channels);

		[CCode (cname = "Mix_ReserveChannels")]
		public static int reserve (int num_channels);

		[CCode (cname = "Mix_ChannelFinished")]
		public static void hook_finished (ChannelFinishedCallback? cb);

		[CCode (cname = "Mix_SetPanning")]
		public int pan (uint8 left, uint8 right);

		[CCode (cname = "Mix_SetPosition")]
		public int position (int16 degrees, uint8 distance);

		[CCode (cname = "Mix_SetDistance")]
		public int distance (uint8 distance);

		[CCode (cname = "Mix_SetReverseStereo")]
		public int reverse_stereo (int flip);

		[CCode (cname = "Mix_PlayChannelTimed")]
		public int play (Chunk chunk, int loops, int ticks = -1);

		[CCode (cname = "Mix_FadeInChannelTimed")]
		public int fade_in (Chunk chunk, int loops, int ms, int ticks = -1);

		[CCode (cname = "Mix_FadeOutChannel")]
		public int fade_out (int ms);

		[CCode (cname = "Mix_FadingChannel")]
		public FadeStatus is_fading ();

		[CCode (cname = "Mix_Volume")]
		public int volume (int num);

		[CCode (cname = "Mix_HaltChannel")]
		public int halt ();

		[CCode (cname = "Mix_ExpireChannel")]
		public int expire (int ticks);

		[CCode (cname = "Mix_Pause")]
		public void pause ();

		[CCode (cname = "Mix_Paused")]
		public int is_paused ();

		[CCode (cname = "Mix_Resume")]
		public void resume ();

		[CCode (cname = "Mix_Playing")]
		public int is_playing ();

		[CCode (cname = "Mix_GetChunk")]
		public Chunk? get_chunk ();
	}// Channel

	[CCode (cname = "-1")]
	public const SDLMixer.Channel DEFAULT_CHANNEL;

	[CCode (cname = "int")]
	[SimpleType]
	public struct ChannelGroup: int {
		[CCode (cname = "Mix_GroupChannel")]
		public static int add (int channel, int group);

		[CCode (cname = "Mix_GroupChannels")]
		public static int add_range (int from_channel, int to_channel, int group);

		[CCode (cname = "Mix_GroupAvailable")]
		public int first_available ();

		[CCode (cname = "Mix_GroupCount")]
		public int count ();

		[CCode (cname = "Mix_GroupOldest")]
		public int oldest ();

		[CCode (cname = "Mix_GroupNewer")]
		public int newest ();

		[CCode (cname = "Mix_HaltGroup")]
		public int halt ();

		[CCode (cname = "Mix_FadeOutGroup")]
		public int fade_out (int ms);
	}// ChannelGroup

}// SDLMixer
