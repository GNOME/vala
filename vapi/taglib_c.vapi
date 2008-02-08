/* taglib_c.vapi
 *
 * Copyright (C) 2008 Andreas Brauchli
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Andreas Brauchli <a.brauchli@elementarea.net>
 */

[CCode (cprefix = "TagLib_", lower_case_cprefix = "taglib_", cheader_filename = "tag_c.h")]
namespace TagLib
{
	[CCode (free_function = "taglib_file_free", lower_case_cprefix = "taglib_file_")]
	public class File
	{
		[CCode (cname = "taglib_file_new")]
		public File (string! filename);

		[CCode (cname = "taglib_file_new_type")]
		public File.type (string! filename, FileType type);

		public Tag tag();
		public AudioProperties audioproperties(); //FIXME: should be assigned to a const TagLib_Audio_Properties*
		public int save();
	}

	[CCode (free_function = "", lower_case_cprefix = "taglib_tag_")]
	public class Tag
	{
		public weak string title();
		public weak string artist();
		public weak string album();
		public weak string comment();
		public weak string genre();
		public uint year();
		public uint track();

		public void set_title(string! title);
		public void set_artist(string! artist);
		public void set_album(string! album);
		public void set_comment(string! comment);
		public void set_genre(string! genre);
		public void set_year(uint year);
		public void set_track(uint track);
	}

	[CCode (free_function = "", cname = "TagLib_AudioProperties", cprefix = "taglib_audioproperties_")]
	public class AudioProperties
	{
		public int length ();
		public int bitrate ();
		public int samplerate ();
		public int channels ();
	}

	public static class TagLib
	{
		/* By default all strings coming into or out of TagLib's C API are in UTF8.
		 * However, it may be desirable for TagLib to operate on Latin1 (ISO-8859-1)
		 * strings in which case this should be set to FALSE.
		 */
		[CCode (cname = "taglib_set_strings_unicode")]
		public static void set_strings_unicode (int unicode);

		/* TagLib can keep track of strings that are created when outputting tag values
		 * and clear them using taglib_tag_clear_strings().  This is enabled by default.
		 * However if you wish to do more fine grained management of strings, you can do
		 * so by setting a management to FALSE.
		 */
		[CCode (cname = "taglib_set_string_management_enabled")]
		public static void set_string_management_enabled (int management);

		[CCode (cname = "taglib_tag_free_strings")]
		public static void free_strings ();
	}

	[CCode (cname = "TagLib_File_Type", cprefix = "TagLib_File_")]
	public enum FileType
	{
		MPEG,
		OggVorbis,
		FLAC,
		MPC
	}
}

