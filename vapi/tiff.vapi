/* libtiff bindings for vala
 *
 * Copyright (C) 2008 Christian Meyer
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
 *       Christian Meyer <chrisime@gnome.org>
 */

[CCode (cname = "", lower_case_cprefix = "", cheader_filename = "tiffio.h")]
namespace Tiff {

	[CCode (cname = "TIFFDataType", cprefix = "TIFF_")]
	public enum DataType {
		NOTYPE, BYTE, ASCII, SHORT, LONG, RATIONAL, SBYTE, UNDEFINED, SSHORT,
		SLONG, SRATIONAL, FLOAT, DOUBLE, IFD
	}

	[CCode (cname = "TIFFIgnoreSense", cprefix = "TIS_")]
	public enum IgnoreSense {
		STORE, EXTRACT, EMPTY
	}

	[CCode (cname = "TIFFHeader")]
	public struct Header {
		public uint16 tiff_magic;
		public uint16 tiff_version;
		public uint32 tiff_diroff;
	}

	[CCode (cname = "TIFFDirEntry")]
	public struct DirEntry {
		public uint16 tdir_tag;
		public uint16 tdir_type;
		public uint32 tdir_count;
		public uint32 tdir_offset;
	}

	[CCode (cname = "TIFFCIELabToRGB")]
	public struct CIELabToRGB {
		public int range;
		public float rstep;
		public float gstep;
		public float bstep;
		public float X0;
		public float Y0;
		public float Z0;
		public Display display;
		[NoArrayLength]
		public float[] Yr2r;
		[NoArrayLength]
		public float[] Yg2g;
		[NoArrayLength]
		public float[] Yb2b;
	}

	[CCode (cname = "TIFFCodec")]
	public struct Codec {
		public string name;
		public uint16 scheme;
		public InitMethod init;
	}

	[CCode (cname = "TIFFDisplay")]
	public struct Display {
		public float[][] d_mat;
		public float d_YCR;
		public float d_YCG;
		public float d_YCB;
		public uint32 d_Vrwr;
		public uint32 d_Vrwg;
		public uint32 d_Vrwb;
		public float d_Y0R;
		public float d_Y0G;
		public float d_Y0B;
		public float d_gammaR;
		public float d_gammaG;
		public float d_gammaB;
	}

	[CCode (cname = "TIFFFieldInfo")]
	public struct FieldInfo {
		public ttag_t field_tag;
		public short field_readcount;
		public short field_writecount;
		public DataType field_type;
		public ushort field_bit;
		public uchar field_oktochange;
		public uchar field_passcount;
		public string field_name;
	}

	private class PutUnion {
		public delegate void any (RGBAImage p1);
		TileContigRoutine contig;
		TileSeparateRoutine separate;
	}

	[CCode (cname = "TIFFRGBAImage")]
	public struct RGBAImage {
		/* Not sure whether third parameter is out or ref */
		public int get;
		public TIFF tif;
		public int stoponerr;
		public int isContig;
		public int alpha;
		public uint32 width;
		public uint32 height;
		public uint16 bitspersample;
		public uint16 samplesperpixel;
		public uint16 orientation;
		public uint16 req_orientation;
		public uint16 photometric;
		public uint16[] redcmap;
		public uint16[] greencmap;
		public uint16[] bluecmap;
		public PutUnion put;
		public RGBValue Map;
		public uint32[,] BWmap;
		public uint32[,] PALmap;
		public YCbCrToRGB ycbcr;
		public CIELabToRGB cielab;
		public int row_offset;
		public int col_offset;
	}

	[CCode (cname = "TIFFTagMethods")]
	public struct TagMethods {
		/* *****************************
		public TIFFVSetMethod vsetfield;
		public TIFFVGetMethod vgetfield;
		***************************** */
		public PrintMethod printdir;
	}

	[CCode (cname = "TIFFTagValue")]
	public struct TagValue {
		public const FieldInfo info;
		public int count;
		public void* value;
	}

	[CCode (cname = "TIFFYCbCrToRGB")]
	public struct YCbCrToRGB {
		public RGBValue clamptab;
		public int Cr_r_tab;
		public int Cb_b_tab;
		public int32[] Cr_g_tab;
		public int32[] Cb_g_tab;
		public int32[] Y_tab;
	}

	[CCode (cname = "TIFFRGBValue")]
	public struct RGBValue : uchar { }

	[CCode (cname = "void")]
	public class tdata_t { }
	[CCode (cname = "uint16")]
	public struct tdir_t : uint16 { }
	[CCode (cname = "void")]
	public class thandle_t { }
	[CCode (cname = "uint32")]
	public struct toff_t : uint32 { }
	[CCode (cname = "uint16")]
	public struct tsample_t : uint16 { }
	[CCode (cname = "int32")]
	public struct tsize_t : int32 { }
	[CCode (cname = "uint32")]
	public struct tstrip_t : uint32 { }
	[CCode (cname = "uint32")]
	public struct ttag_t : uint32 { }
	[CCode (cname = "uint32")]
	public struct ttile_t : uint32 { }

	public static delegate int get (RGBAImage p1, out uint32 p2, uint32 p3, uint32 p4);
	[CCode (cname= "TIFFCloseProc")]
	public static delegate int CloseProc (thandle_t p1);
	/* ***********************************************************************************
	[CCode (cname= "TIFFErrorHandler")]
	public static delegate void ErrorHandler (string p1, string p2, void* p3);
	[CCode (cname= "TIFFErrorHandlerExt")]
	public static delegate void ErrorHandlerExt (thandle_t p1, string p2, string p3, ...);
	*********************************************************************************** */
	[CCode (cname= "TIFFExtendProc")]
	public static delegate void ExtendProc (TIFF p1);
	[CCode (cname= "TIFFInitMethod")]
	public static delegate int InitMethod (TIFF p1, int p2);
	[CCode (cname= "TIFFMapFileProc")]
	public static delegate int MapFileProc (thandle_t p1, ref tdata_t p2, ref toff_t p3);
	[CCode (cname= "TIFFPrintMethod")]
	public static delegate void PrintMethod (TIFF p1, GLib.FileStream p2, long p3);
	[CCode (cname= "TIFFReadWriteProc")]
	public static delegate tsize_t ReadWriteProc (thandle_t p1, tdata_t p2, tsize_t p3);
	[CCode (cname= "TIFFSeekProc")]
	public static delegate toff_t SeekProc (thandle_t p1, toff_t p2, int p3);
	[CCode (cname= "TIFFSizeProc")]
	public static delegate toff_t SizeProc (thandle_t p1);
	[CCode (cname= "TIFFUnmapFileProc")]
	public static delegate void UnmapFileProc (thandle_t p1, tdata_t p2, toff_t p3);
	/* *************************************************************
	[CCode (cname= "TIFFVGetMethod")]
	public static delegate int VGetMethod (TIFF p1, ttag_t p2, ...);
	[CCode (cname= "TIFFVSetMethod")]
	public static delegate int VSetMethod (TIFF p1, ttag_t p2, ...);
	************************************************************* */
	[CCode (cname= "tileContigRoutine")]
	public static delegate void TileContigRoutine (RGBAImage p1, uint32* p2, uint32 p3, uint32 p4, uint32 p5, uint32 p6, int32 p7, int32 p8, uchar *p9);
	[CCode (cname= "tileSeparateRoutine")]
	public static delegate void TileSeparateRoutine (RGBAImage p1, uint32* p2, uint32 p3, uint32 p4, uint32 p5, uint32 p6, int32 p7, int32 p8, uchar p9, uchar p10, uchar p11, uchar p12);

	public const int CIELABTORGB_TABLE_RANGE;
	public const int CLEANFAXDATA_CLEAN;
	public const int CLEANFAXDATA_REGENERATED;
	public const int CLEANFAXDATA_UNCLEAN;
	public const int COLORRESPONSEUNIT_100000S;
	public const int COLORRESPONSEUNIT_10000S;
	public const int COLORRESPONSEUNIT_1000S;
	public const int COLORRESPONSEUNIT_100S;
	public const int COLORRESPONSEUNIT_10S;
	public const int COMPRESSION_ADOBE_DEFLATE;
	public const int COMPRESSION_CCITTFAX3;
	public const int COMPRESSION_CCITTFAX4;
	public const int COMPRESSION_CCITTRLE;
	public const int COMPRESSION_CCITTRLEW;
	public const int COMPRESSION_CCITT_T4;
	public const int COMPRESSION_CCITT_T6;
	public const int COMPRESSION_DEFLATE;
	public const int COMPRESSION_IT8BL;
	public const int COMPRESSION_IT8CTPAD;
	public const int COMPRESSION_IT8LW;
	public const int COMPRESSION_IT8MP;
	public const int COMPRESSION_JBIG;
	public const int COMPRESSION_JP2000;
	public const int COMPRESSION_JPEG;
	public const int COMPRESSION_LZW;
	public const int COMPRESSION_NEXT;
	public const int COMPRESSION_NONE;
	public const int COMPRESSION_OJPEG;
	public const int COMPRESSION_PACKBITS;
	public const int COMPRESSION_PIXARFILM;
	public const int COMPRESSION_PIXARLOG;
	public const int COMPRESSION_SGILOG;
	public const int COMPRESSION_SGILOG24;
	public const int COMPRESSION_THUNDERSCAN;
	public const int DCSIMAGERFILTER_CFA;
	public const int DCSIMAGERFILTER_IR;
	public const int DCSIMAGERFILTER_MONO;
	public const int DCSIMAGERFILTER_OTHER;
	public const int DCSIMAGERMODEL_M3;
	public const int DCSIMAGERMODEL_M5;
	public const int DCSIMAGERMODEL_M6;
	public const int DCSINTERPMODE_NORMAL;
	public const int DCSINTERPMODE_PREVIEW;
	public const int EXIFTAG_APERTUREVALUE;
	public const int EXIFTAG_BRIGHTNESSVALUE;
	public const int EXIFTAG_CFAPATTERN;
	public const int EXIFTAG_COLORSPACE;
	public const int EXIFTAG_COMPRESSEDBITSPERPIXEL;
	public const int EXIFTAG_CONTRAST;
	public const int EXIFTAG_CUSTOMRENDERED;
	public const int EXIFTAG_DATETIMEORIGINAL;
	public const int EXIFTAG_DEVICESETTINGDESCRIPTION;
	public const int EXIFTAG_DIGITALZOOMRATIO;
	public const int EXIFTAG_EXPOSUREBIASVALUE;
	public const int EXIFTAG_EXPOSUREINDEX;
	public const int EXIFTAG_EXPOSUREMODE;
	public const int EXIFTAG_EXPOSUREPROGRAM;
	public const int EXIFTAG_EXPOSURETIME;
	public const int EXIFTAG_FILESOURCE;
	public const int EXIFTAG_FLASH;
	public const int EXIFTAG_FLASHENERGY;
	public const int EXIFTAG_FLASHPIXVERSION;
	public const int EXIFTAG_FNUMBER;
	public const int EXIFTAG_FOCALLENGTH;
	public const int EXIFTAG_FOCALLENGTHIN35MMFILM;
	public const int EXIFTAG_FOCALPLANERESOLUTIONUNIT;
	public const int EXIFTAG_FOCALPLANEXRESOLUTION;
	public const int EXIFTAG_FOCALPLANEYRESOLUTION;
	public const int EXIFTAG_GAINCONTROL;
	public const int EXIFTAG_IMAGEUNIQUEID;
	public const int EXIFTAG_ISOSPEEDRATINGS;
	public const int EXIFTAG_LIGHTSOURCE;
	public const int EXIFTAG_MAKERNOTE;
	public const int EXIFTAG_MAXAPERTUREVALUE;
	public const int EXIFTAG_METERINGMODE;
	public const int EXIFTAG_OECF;
	public const int EXIFTAG_PIXELXDIMENSION;
	public const int EXIFTAG_PIXELYDIMENSION;
	public const int EXIFTAG_RELATEDSOUNDFILE;
	public const int EXIFTAG_SATURATION;
	public const int EXIFTAG_SCENECAPTURETYPE;
	public const int EXIFTAG_SCENETYPE;
	public const int EXIFTAG_SENSINGMETHOD;
	public const int EXIFTAG_SHARPNESS;
	public const int EXIFTAG_SHUTTERSPEEDVALUE;
	public const int EXIFTAG_SPATIALFREQUENCYRESPONSE;
	public const int EXIFTAG_SPECTRALSENSITIVITY;
	public const int EXIFTAG_SUBJECTAREA;
	public const int EXIFTAG_SUBJECTDISTANCE;
	public const int EXIFTAG_SUBJECTDISTANCERANGE;
	public const int EXIFTAG_SUBJECTLOCATION;
	public const int EXIFTAG_SUBSECTIME;
	public const int EXIFTAG_SUBSECTIMEDIGITIZED;
	public const int EXIFTAG_SUBSECTIMEORIGINAL;
	public const int EXIFTAG_USERCOMMENT;
	public const int EXIFTAG_WHITEBALANCE;
	public const int EXTRASAMPLE_ASSOCALPHA;
	public const int EXTRASAMPLE_UNASSALPHA;
	public const int EXTRASAMPLE_UNSPECIFIED;
	public const int FAXMODE_BYTEALIGN;
	public const int FAXMODE_CLASSIC;
	public const int FAXMODE_NOEOL;
	public const int FAXMODE_NORTC;
	public const int FAXMODE_WORDALIGN;
	public const int FIELD_CUSTOM;
	public const int FILETYPE_MASK;
	public const int FILETYPE_PAGE;
	public const int FILETYPE_REDUCEDIMAGE;
	public const int FILLORDER_LSB2MSB;
	public const int FILLORDER_MSB2LSB;
	public const int GRAYRESPONSEUNIT_100000S;
	public const int GRAYRESPONSEUNIT_10000S;
	public const int GRAYRESPONSEUNIT_1000S;
	public const int GRAYRESPONSEUNIT_100S;
	public const int GRAYRESPONSEUNIT_10S;
	public const int GROUP3OPT_2DENCODING;
	public const int GROUP3OPT_FILLBITS;
	public const int GROUP3OPT_UNCOMPRESSED;
	public const int GROUP4OPT_UNCOMPRESSED;
	public const int INKSET_CMYK;
	public const int INKSET_MULTIINK;
	public const int JPEGCOLORMODE_RAW;
	public const int JPEGCOLORMODE_RGB;
	public const int JPEGPROC_BASELINE;
	public const int JPEGPROC_LOSSLESS;
	public const int JPEGTABLESMODE_HUFF;
	public const int JPEGTABLESMODE_QUANT;
	public const int LOGLUV_PUBLIC;
	public const int MDI_BIGENDIAN;
	public const int MDI_LITTLEENDIAN;
	public const int OFILETYPE_IMAGE;
	public const int OFILETYPE_PAGE;
	public const int OFILETYPE_REDUCEDIMAGE;
	public const int ORIENTATION_BOTLEFT;
	public const int ORIENTATION_BOTRIGHT;
	public const int ORIENTATION_LEFTBOT;
	public const int ORIENTATION_LEFTTOP;
	public const int ORIENTATION_RIGHTBOT;
	public const int ORIENTATION_RIGHTTOP;
	public const int ORIENTATION_TOPLEFT;
	public const int ORIENTATION_TOPRIGHT;
	public const int PHOTOMETRIC_CIELAB;
	public const int PHOTOMETRIC_ICCLAB;
	public const int PHOTOMETRIC_ITULAB;
	public const int PHOTOMETRIC_LOGL;
	public const int PHOTOMETRIC_LOGLUV;
	public const int PHOTOMETRIC_MASK;
	public const int PHOTOMETRIC_MINISBLACK;
	public const int PHOTOMETRIC_MINISWHITE;
	public const int PHOTOMETRIC_PALETTE;
	public const int PHOTOMETRIC_RGB;
	public const int PHOTOMETRIC_SEPARATED;
	public const int PHOTOMETRIC_YCBCR;
	public const int PIXARLOGDATAFMT_11BITLOG;
	public const int PIXARLOGDATAFMT_12BITPICIO;
	public const int PIXARLOGDATAFMT_16BIT;
	public const int PIXARLOGDATAFMT_8BIT;
	public const int PIXARLOGDATAFMT_8BITABGR;
	public const int PIXARLOGDATAFMT_FLOAT;
	public const int PLANARCONFIG_CONTIG;
	public const int PLANARCONFIG_SEPARATE;
	public const int PREDICTOR_FLOATINGPOINT;
	public const int PREDICTOR_HORIZONTAL;
	public const int PREDICTOR_NONE;
	public const int RESUNIT_CENTIMETER;
	public const int RESUNIT_INCH;
	public const int RESUNIT_NONE;
	public const int SAMPLEFORMAT_COMPLEXIEEEFP;
	public const int SAMPLEFORMAT_COMPLEXINT;
	public const int SAMPLEFORMAT_IEEEFP;
	public const int SAMPLEFORMAT_INT;
	public const int SAMPLEFORMAT_UINT;
	public const int SAMPLEFORMAT_VOID;
	public const int SGILOGDATAFMT_16BIT;
	public const int SGILOGDATAFMT_8BIT;
	public const int SGILOGDATAFMT_FLOAT;
	public const int SGILOGDATAFMT_RAW;
	public const int SGILOGENCODE_NODITHER;
	public const int SGILOGENCODE_RANDITHER;
	public const int THRESHHOLD_BILEVEL;
	public const int THRESHHOLD_ERRORDIFFUSE;
	public const int THRESHHOLD_HALFTONE;
	public const int TIFFPRINT_COLORMAP;
	public const int TIFFPRINT_CURVES;
	public const int TIFFPRINT_JPEGACTABLES;
	public const int TIFFPRINT_JPEGDCTABLES;
	public const int TIFFPRINT_JPEGQTABLES;
	public const int TIFFPRINT_NONE;
	public const int TIFFPRINT_STRIPS;
	public const ttag_t TIFFTAG_ANTIALIASSTRENGTH;
	public const ttag_t TIFFTAG_ARTIST;
	public const ttag_t TIFFTAG_ASSHOTPREPROFILEMATRIX;
	public const ttag_t TIFFTAG_BADFAXLINES;
	public const ttag_t TIFFTAG_BASELINESHARPNESS;
	public const ttag_t TIFFTAG_BESTQUALITYSCALE;
	public const ttag_t TIFFTAG_BITSPERSAMPLE;
	public const ttag_t TIFFTAG_BLACKLEVELDELTAH;
	public const ttag_t TIFFTAG_BLACKLEVELREPEATDIM;
	public const ttag_t TIFFTAG_CALIBRATIONILLUMINANT2;
	public const ttag_t TIFFTAG_CAMERACALIBRATION2;
	public const ttag_t TIFFTAG_CAMERASERIALNUMBER;
	public const ttag_t TIFFTAG_CELLLENGTH;
	public const ttag_t TIFFTAG_CELLWIDTH;
	public const ttag_t TIFFTAG_CHROMABLURRADIUS;
	public const ttag_t TIFFTAG_CLEANFAXDATA;
	public const ttag_t TIFFTAG_CLIPPATH;
	public const ttag_t TIFFTAG_COLORMAP;
	public const ttag_t TIFFTAG_COLORRESPONSEUNIT;
	public const ttag_t TIFFTAG_COMPRESSION;
	public const ttag_t TIFFTAG_CONSECUTIVEBADFAXLINES;
	public const ttag_t TIFFTAG_COPYRIGHT;
	public const ttag_t TIFFTAG_CURRENTPREPROFILEMATRIX;
	public const ttag_t TIFFTAG_DATATYPE;
	public const ttag_t TIFFTAG_DATETIME;
	public const ttag_t TIFFTAG_DCSBALANCEARRAY;
	public const ttag_t TIFFTAG_DCSCALIBRATIONFD;
	public const ttag_t TIFFTAG_DCSCLIPRECTANGLE;
	public const ttag_t TIFFTAG_DCSCORRECTMATRIX;
	public const ttag_t TIFFTAG_DCSGAMMA;
	public const ttag_t TIFFTAG_DCSHUESHIFTVALUES;
	public const ttag_t TIFFTAG_DCSIMAGERTYPE;
	public const ttag_t TIFFTAG_DCSINTERPMODE;
	public const ttag_t TIFFTAG_DCSTOESHOULDERPTS;
	public const ttag_t TIFFTAG_DEFAULTCROPORIGIN;
	public const ttag_t TIFFTAG_DNGBACKWARDVERSION;
	public const ttag_t TIFFTAG_DNGPRIVATEDATA;
	public const ttag_t TIFFTAG_DNGVERSION;
	public const ttag_t TIFFTAG_DOCUMENTNAME;
	public const ttag_t TIFFTAG_DOTRANGE;
	public const ttag_t TIFFTAG_EXIFIFD;
	public const ttag_t TIFFTAG_EXTRASAMPLES;
	public const ttag_t TIFFTAG_FAXDCS;
	public const ttag_t TIFFTAG_FAXFILLFUNC;
	public const ttag_t TIFFTAG_FAXMODE;
	public const ttag_t TIFFTAG_FAXRECVPARAMS;
	public const ttag_t TIFFTAG_FAXRECVTIME;
	public const ttag_t TIFFTAG_FAXSUBADDRESS;
	public const ttag_t TIFFTAG_FEDEX_EDR;
	public const ttag_t TIFFTAG_FILLORDER;
	public const ttag_t TIFFTAG_FRAMECOUNT;
	public const ttag_t TIFFTAG_FREEBYTECOUNTS;
	public const ttag_t TIFFTAG_FREEOFFSETS;
	public const ttag_t TIFFTAG_GPSIFD;
	public const ttag_t TIFFTAG_GRAYRESPONSECURVE;
	public const ttag_t TIFFTAG_GRAYRESPONSEUNIT;
	public const ttag_t TIFFTAG_GROUP3OPTIONS;
	public const ttag_t TIFFTAG_GROUP4OPTIONS;
	public const ttag_t TIFFTAG_HALFTONEHINTS;
	public const ttag_t TIFFTAG_HOSTCOMPUTER;
	public const ttag_t TIFFTAG_ICCPROFILE;
	public const ttag_t TIFFTAG_IMAGEDEPTH;
	public const ttag_t TIFFTAG_IMAGEDESCRIPTION;
	public const ttag_t TIFFTAG_IMAGELENGTH;
	public const ttag_t TIFFTAG_IMAGEWIDTH;
	public const ttag_t TIFFTAG_INKNAMES;
	public const ttag_t TIFFTAG_INKSET;
	public const ttag_t TIFFTAG_INTEROPERABILITYIFD;
	public const ttag_t TIFFTAG_IT8BITSPEREXTENDEDRUNLENGTH;
	public const ttag_t TIFFTAG_IT8BITSPERRUNLENGTH;
	public const ttag_t TIFFTAG_IT8BKGCOLORINDICATOR;
	public const ttag_t TIFFTAG_IT8BKGCOLORVALUE;
	public const ttag_t TIFFTAG_IT8COLORCHARACTERIZATION;
	public const ttag_t TIFFTAG_IT8COLORSEQUENCE;
	public const ttag_t TIFFTAG_IT8COLORTABLE;
	public const ttag_t TIFFTAG_IT8HCUSAGE;
	public const ttag_t TIFFTAG_IT8HEADER;
	public const ttag_t TIFFTAG_IT8IMAGECOLORINDICATOR;
	public const ttag_t TIFFTAG_IT8IMAGECOLORVALUE;
	public const ttag_t TIFFTAG_IT8PIXELINTENSITYRANGE;
	public const ttag_t TIFFTAG_IT8RASTERPADDING;
	public const ttag_t TIFFTAG_IT8SITE;
	public const ttag_t TIFFTAG_IT8TRANSPARENCYINDICATOR;
	public const ttag_t TIFFTAG_IT8TRAPINDICATOR;
	public const ttag_t TIFFTAG_JBIGOPTIONS;
	public const ttag_t TIFFTAG_JPEGACTABLES;
	public const ttag_t TIFFTAG_JPEGCOLORMODE;
	public const ttag_t TIFFTAG_JPEGDCTABLES;
	public const ttag_t TIFFTAG_JPEGIFBYTECOUNT;
	public const ttag_t TIFFTAG_JPEGIFOFFSET;
	public const ttag_t TIFFTAG_JPEGLOSSLESSPREDICTORS;
	public const ttag_t TIFFTAG_JPEGPOINTTRANSFORM;
	public const ttag_t TIFFTAG_JPEGPROC;
	public const ttag_t TIFFTAG_JPEGQTABLES;
	public const ttag_t TIFFTAG_JPEGQUALITY;
	public const ttag_t TIFFTAG_JPEGRESTARTINTERVAL;
	public const ttag_t TIFFTAG_JPEGTABLESMODE;
	public const ttag_t TIFFTAG_LENSINFO;
	public const ttag_t TIFFTAG_LINEARIZATIONTABLE;
	public const ttag_t TIFFTAG_LOCALIZEDCAMERAMODEL;
	public const ttag_t TIFFTAG_MAKE;
	public const ttag_t TIFFTAG_MAKERNOTESAFETY;
	public const ttag_t TIFFTAG_MATTEING;
	public const ttag_t TIFFTAG_MAXSAMPLEVALUE;
	public const ttag_t TIFFTAG_MINSAMPLEVALUE;
	public const ttag_t TIFFTAG_MODEL;
	public const ttag_t TIFFTAG_NUMBEROFINKS;
	public const ttag_t TIFFTAG_OPIPROXY;
	public const ttag_t TIFFTAG_ORIENTATION;
	public const ttag_t TIFFTAG_OSUBFILETYPE;
	public const ttag_t TIFFTAG_PAGENAME;
	public const ttag_t TIFFTAG_PAGENUMBER;
	public const ttag_t TIFFTAG_PHOTOMETRIC;
	public const ttag_t TIFFTAG_PHOTOSHOP;
	public const ttag_t TIFFTAG_PIXARLOGDATAFMT;
	public const ttag_t TIFFTAG_PIXARLOGQUALITY;
	public const ttag_t TIFFTAG_PIXAR_FOVCOT;
	public const ttag_t TIFFTAG_PIXAR_IMAGEFULLLENGTH;
	public const ttag_t TIFFTAG_PIXAR_IMAGEFULLWIDTH;
	public const ttag_t TIFFTAG_PIXAR_MATRIX_WORLDTOCAMERA;
	public const ttag_t TIFFTAG_PIXAR_MATRIX_WORLDTOSCREEN;
	public const ttag_t TIFFTAG_PIXAR_TEXTUREFORMAT;
	public const ttag_t TIFFTAG_PIXAR_WRAPMODES;
	public const ttag_t TIFFTAG_PLANARCONFIG;
	public const ttag_t TIFFTAG_PREDICTOR;
	public const ttag_t TIFFTAG_PRIMARYCHROMATICITIES;
	public const ttag_t TIFFTAG_RAWDATAUNIQUEID;
	public const ttag_t TIFFTAG_REDUCTIONMATRIX1;
	public const ttag_t TIFFTAG_REFERENCEBLACKWHITE;
	public const ttag_t TIFFTAG_REGIONAFFINE;
	public const ttag_t TIFFTAG_REGIONTACKPOINT;
	public const ttag_t TIFFTAG_REGIONWARPCORNERS;
	public const ttag_t TIFFTAG_RESOLUTIONUNIT;
	public const ttag_t TIFFTAG_RICHTIFFIPTC;
	public const ttag_t TIFFTAG_ROWSPERSTRIP;
	public const ttag_t TIFFTAG_SAMPLEFORMAT;
	public const ttag_t TIFFTAG_SAMPLESPERPIXEL;
	public const ttag_t TIFFTAG_SGILOGDATAFMT;
	public const ttag_t TIFFTAG_SGILOGENCODE;
	public const ttag_t TIFFTAG_SMAXSAMPLEVALUE;
	public const ttag_t TIFFTAG_SMINSAMPLEVALUE;
	public const ttag_t TIFFTAG_SOFTWARE;
	public const ttag_t TIFFTAG_STONITS;
	public const ttag_t TIFFTAG_STRIPBYTECOUNTS;
	public const ttag_t TIFFTAG_STRIPOFFSETS;
	public const ttag_t TIFFTAG_SUBFILETYPE;
	public const ttag_t TIFFTAG_SUBIFD;
	public const ttag_t TIFFTAG_T4OPTIONS;
	public const ttag_t TIFFTAG_T6OPTIONS;
	public const ttag_t TIFFTAG_TARGETPRINTER;
	public const ttag_t TIFFTAG_THRESHHOLDING;
	public const ttag_t TIFFTAG_TILEBYTECOUNTS;
	public const ttag_t TIFFTAG_TILEDEPTH;
	public const ttag_t TIFFTAG_TILELENGTH;
	public const ttag_t TIFFTAG_TILEOFFSETS;
	public const ttag_t TIFFTAG_TILEWIDTH;
	public const ttag_t TIFFTAG_TRANSFERFUNCTION;
	public const ttag_t TIFFTAG_UNIQUECAMERAMODEL;
	public const ttag_t TIFFTAG_WHITEPOINT;
	public const ttag_t TIFFTAG_WRITERSERIALNUMBER;
	public const ttag_t TIFFTAG_XMLPACKET;
	public const ttag_t TIFFTAG_XPOSITION;
	public const ttag_t TIFFTAG_XRESOLUTION;
	public const ttag_t TIFFTAG_YCBCRCOEFFICIENTS;
	public const ttag_t TIFFTAG_YCBCRPOSITIONING;
	public const ttag_t TIFFTAG_YCBCRSUBSAMPLING;
	public const ttag_t TIFFTAG_YPOSITION;
	public const ttag_t TIFFTAG_YRESOLUTION;
	public const ttag_t TIFFTAG_ZIPQUALITY;
	public const int BIGENDIAN;
	public const int BIGTIFF_VERSION;
	public const int DIROFFSET_SIZE;
	public const int LITTLEENDIAN;
	public const int MAGIC_SIZE;
	public const int SPP;
	public const int VARIABLE;
	public const int VARIABLE2;
	public const int VERSION;
	public const int VERSION_SIZE;
	public const int YCBCRPOSITION_CENTERED;
	public const int YCBCRPOSITION_COSITED;

	[CCode (cname = "TIFF", free_function = "TIFFClose")]
	public class TIFF {
		[CCode (cname = "TIFFOpen")]
		public TIFF (string path, string mode);
		[CCode (cname = "TIFFAccessTagMethods")]
		public TagMethods AccessTagMethods ();
		[CCode (cname = "TIFFCheckTile")]
		public int CheckTile (uint32 p1, uint32 p2, uint32 p3, tsample_t p4);
		[CCode (cname = "TIFFCheckpointDirectory")]
		public int CheckpointDirectory ();
		[CCode (cname = "TIFFCleanup")]
		public void Cleanup ();
		[CCode (cname = "TIFFClientdata")]
		public thandle_t Clientdata ();
		[CCode (cname = "TIFFComputeStrip")]
		public tstrip_t ComputeStrip (uint p1, tsample_t p2);
		[CCode (cname = "TIFFComputeTile")]
		public ttile_t ComputeTile (uint32 p1, uint32 p2, uint32 p3, tsample_t p4);
		[CCode (cname = "TIFFCreateDirectory")]
		public int CreateDirectory ();
		[CCode (cname = "TIFFCurrentDirOffset")]
		public uint CurrentDirOffset ();
		[CCode (cname = "TIFFCurrentDirectory")]
		public tdir_t CurrentDirectory ();
		[CCode (cname = "TIFFCurrentRow")]
		public uint CurrentRow ();
		[CCode (cname = "TIFFCurrentStrip")]
		public tstrip_t CurrentStrip ();
		[CCode (cname = "TIFFCurrentTile")]
		public ttile_t CurrentTile ();
		[CCode (cname = "TIFFDefaultStripSize")]
		public uint DefaultStripSize (uint32 p1);
		[CCode (cname = "TIFFDefaultTileSize")]
		public void DefaultTileSize (out uint32 p1, out uint32 p2);
		[CCode (cname = "TIFFFieldWithName")]
		public FieldInfo FieldWithName (string p1);
		[CCode (cname = "TIFFFieldWithTag")]
		public FieldInfo FieldWithTag (ttag_t p1);
		[CCode (cname = "TIFFFileName")]
		public string FileName ();
		[CCode (cname = "TIFFFileno")]
		public int Fileno ();
		[CCode (cname = "TIFFFindFieldInfo")]
		public FieldInfo FindFieldInfo (ttag_t p1, DataType p2);
		[CCode (cname = "TIFFFindFieldInfoByName")]
		public FieldInfo FindFieldInfoByName (string p1, DataType p2);
		[CCode (cname = "TIFFFlush")]
		public int Flush ();
		[CCode (cname = "TIFFFlushData")]
		public int FlushData ();
		[CCode (cname = "TIFFFreeDirectory")]
		public void FreeDirectory ();
		[CCode (cname = "TIFFGetClientInfo")]
		public void* GetClientInfo (string p1);
		[CCode (cname = "TIFFGetCloseProc")]
		public CloseProc GetCloseProc ();
		[CCode (cname = "TIFFGetField")]
		public int GetField (ttag_t p1, ...);
		[CCode (cname = "TIFFGetFieldDefaulted")]
		public int GetFieldDefaulted (ttag_t p1, ...);
		[CCode (cname = "TIFFGetMapFileProc")]
		public MapFileProc GetMapFileProc ();
		[CCode (cname = "TIFFGetMode")]
		public int GetMode ();
		[CCode (cname = "TIFFGetReadProc")]
		public ReadWriteProc GetReadProc ();
		[CCode (cname = "TIFFGetSeekProc")]
		public SeekProc GetSeekProc ();
		[CCode (cname = "TIFFGetSizeProc")]
		public SizeProc GetSizeProc ();
		[CCode (cname = "TIFFGetTagListCount")]
		public int GetTagListCount ();
		[CCode (cname = "TIFFGetTagListEntry")]
		public ttag_t GetTagListEntry (int tag_index);
		[CCode (cname = "TIFFGetUnmapFileProc")]
		public UnmapFileProc GetUnmapFileProc ();
		[CCode (cname = "TIFFGetWriteProc")]
		public ReadWriteProc GetWriteProc ();
		[CCode (cname = "TIFFIsBigEndian")]
		public int IsBigEndian ();
		[CCode (cname = "TIFFIsByteSwapped")]
		public int IsByteSwapped ();
		[CCode (cname = "TIFFIsMSB2LSB")]
		public int IsMSB2LSB ();
		[CCode (cname = "TIFFIsTiled")]
		public int IsTiled ();
		[CCode (cname = "TIFFIsUpSampled")]
		public int IsUpSampled ();
		[CCode (cname = "TIFFLastDirectory")]
		public int LastDirectory ();
		[CCode (cname = "TIFFMergeFieldInfo")]
		public void MergeFieldInfo (FieldInfo[] p1, int p2);
		[CCode (cname = "TIFFNumberOfDirectories")]
		public tdir_t NumberOfDirectories ();
		[CCode (cname = "TIFFNumberOfStrips")]
		public tstrip_t NumberOfStrips ();
		[CCode (cname = "TIFFNumberOfTiles")]
		public ttile_t NumberOfTiles ();
		[CCode (cname = "TIFFPrintDirectory")]
		public void PrintDirectory (GLib.FileStream p1, long p2);
		[CCode (cname = "TIFFRGBAImageOK")]
		public int RGBAImageOK (string[] p1);
		[CCode (cname = "TIFFRasterScanlineSize")]
		public tsize_t RasterScanlineSize ();
		[CCode (cname = "TIFFRawStripSize")]
		public tsize_t RawStripSize (tstrip_t p1);
		[CCode (cname = "TIFFReadBufferSetup")]
		public int ReadBufferSetup (tdata_t p1, tsize_t p2);
		[CCode (cname = "TIFFReadCustomDirectory")]
		public int ReadCustomDirectory (toff_t p1, FieldInfo[] p2, size_t p3);
		[CCode (cname = "TIFFReadDirectory")]
		public int ReadDirectory ();
		[CCode (cname = "TIFFReadEXIFDirectory")]
		public int ReadEXIFDirectory (toff_t p1);
		[CCode (cname = "TIFFReadEncodedStrip")]
		public tsize_t ReadEncodedStrip (tstrip_t p1, tdata_t p2, tsize_t p3);
		[CCode (cname = "TIFFReadEncodedTile")]
		public tsize_t ReadEncodedTile (ttile_t p1, tdata_t p2, tsize_t p3);
		[NoArrayLength]
		[CCode (cname = "TIFFReadRGBAImage")]
		public int ReadRGBAImage (uint32 p1, uint32 p2, out uint32[] p3, int p4);
		[NoArrayLength]
		[CCode (cname = "TIFFReadRGBAImageOriented")]
		public int ReadRGBAImageOriented (uint32 p1, uint32 p2, out uint32[] p3, int p4, int p5);
		[CCode (cname = "TIFFReadRGBAStrip")]
		public int ReadRGBAStrip (tstrip_t p1, out uint32[] p2);
		[CCode (cname = "TIFFReadRawTile")]
		public int ReadRGBATile (uint32 p1, uint32 p2, out uint32[] p3);
		[CCode (cname = "TIFFReadRawStrip")]
		public tsize_t ReadRawStrip (tstrip_t p1, tdata_t p2, tsize_t p3);
		[CCode (cname = "TIFFReadRawTile")]
		public tsize_t ReadRawTile (ttile_t p1, tdata_t p2, tsize_t p3);
		[CCode (cname = "TIFFReadScanline")]
		public int ReadScanline (tdata_t p1, uint32 p2, tsample_t p3);
		[CCode (cname = "TIFFReadTile")]
		public tsize_t ReadTile (tdata_t p1, uint32 p2, uint32 p3, uint32 p4, tsample_t p5);
		[CCode (cname = "TIFFRewriteDirectory")]
		public int RewriteDirectory ();
		[CCode (cname = "TIFFScanlineSize")]
		public tsize_t ScanlineSize ();
		[CCode (cname = "TIFFSetClientInfo")]
		public void SetClientInfo (void* p1, string p2);
		[CCode (cname = "TIFFSetClientdata")]
		public thandle_t SetClientdata (thandle_t p1);
		[CCode (cname = "TIFFSetDirectory")]
		public int SetDirectory (tdir_t p1);
		[CCode (cname = "TIFFSetField")]
		public int SetField (ttag_t p1, ...);
		[CCode (cname = "TIFFSetFileName")]
		public string SetFileName (string p1);
		[CCode (cname = "TIFFSetFileno")]
		public int SetFileno (int p1);
		[CCode (cname = "TIFFSetMode")]
		public int SetMode (int p1);
		[CCode (cname = "TIFFSetSubDirectory")]
		public int SetSubDirectory (uint32 p1);
		[CCode (cname = "TIFFSetWriteOffset")]
		public void SetWriteOffset (toff_t p1);
		[CCode (cname = "TIFFSetupStrips")]
		public int SetupStrips ();
		[CCode (cname = "TIFFStripSize")]
		public tsize_t StripSize ();
		[CCode (cname = "TIFFTileRowSize")]
		public tsize_t TileRowSize ();
		[CCode (cname = "TIFFTileSize")]
		public tsize_t TileSize ();
		[CCode (cname = "TIFFUnlinkDirectory")]
		public int UnlinkDirectory (tdir_t p1);
		/* *************************************************
		[CCode (cname = "TIFFVGetField")]
		public int VGetField (ttag_t p1, void* p2);
		[CCode (cname = "TIFFVGetFieldDefaulted")]
		public int VGetFieldDefaulted (ttag_t p1, void* p2);
		[CCode (cname = "TIFFVSetField")]
		public int VSetField (ttag_t p1, void* p2);
		************************************************* */
		[CCode (cname = "TIFFVStripSize")]
		public tsize_t VStripSize (uint32 p1);
		[CCode (cname = "TIFFVTileSize")]
		public tsize_t VTileSize (uint32 p1);
		[CCode (cname = "TIFFWriteBufferSetup")]
		public int WriteBufferSetup (tdata_t p1, tsize_t p2);
		[CCode (cname = "TIFFWriteCheck")]
		public int WriteCheck (int p1, string p2);
		[CCode (cname = "TIFFWriteDirectory")]
		public int WriteDirectory ();
		[CCode (cname = "TIFFWriteEncodedStrip")]
		public tsize_t WriteEncodedStrip (tstrip_t p1, tdata_t p2, tsize_t p3);
		[CCode (cname = "TIFFWriteEncodedTile")]
		public tsize_t WriteEncodedTile (ttile_t p1, tdata_t p2, tsize_t p3);
		[CCode (cname = "TIFFWriteRawStrip")]
		public tsize_t WriteRawStrip (tstrip_t p1, tdata_t p2, tsize_t p3);
		[CCode (cname = "TIFFWriteRawTile")]
		public tsize_t WriteRawTile (ttile_t p1, tdata_t p2, tsize_t p3);
		[CCode (cname = "TIFFWriteScanline")]
		public int WriteScanline (tdata_t p1, uint32 p2, tsample_t p3);
		[CCode (cname = "TIFFWriteTile")]
		public tsize_t WriteTile (tdata_t p1, uint32 p2, uint32 p3, uint32 p4, tsample_t p5);
		[CCode (cname = "TIFFGetR")]
		public static int GetRed (int32 abgr);
		[CCode (cname = "TIFFGetG")]
		public static int GetGreen (int32 abgr);
		[CCode (cname = "TIFFGetB")]
		public static int GetBlue (int32 abgr);
		[CCode (cname = "TIFFGetA")]
		public static int GetAlpha (int32 abgr);
		[CCode (cname = "TIFFClientOpen")]
		public static TIFF ClientOpen (string p1, string p2, thandle_t p3, ReadWriteProc p4, ReadWriteProc p5, SeekProc p6, CloseProc p7, SizeProc p8, MapFileProc p9, UnmapFileProc p10);
		[CCode (cname = "TIFFCIELabToRGBInit")]
		public static int CIELabToRGBInit (ref CIELabToRGB p1, ref Display p2, ref float p3);
		[CCode (cname = "TIFFCIELabToXYZ")]
		public static void CIELabToXYZ (ref CIELabToRGB p1, uint p2, int p3, int p4, out float p5, out float p6, out float p7);
		[CCode (cname = "TIFFDataWidth")]
		public static int DataWidth (DataType p1);
		[CCode (cname = "TIFFError")]
		public static void Error (string p1, string p2, ...);
		[CCode (cname = "TIFFErrorExt")]
		public static void ErrorExt (thandle_t p1, string p2, string p3, ...);
		[CCode (cname = "TIFFFdOpen")]
		public static TIFF FdOpen (int p1, string p2, string p3);
		[CCode (cname = "TIFFGetVersion")]
		public static string GetVersion ();
		[CCode (cname = "TIFFFindCODEC")]
		public static Codec FindCODEC (ushort p1);
		[CCode (cname = "TIFFGetBitRevTable")]
		public static uint GetBitRevTable (int p1);
		[CCode (cname = "TIFFGetConfiguredCODECs")]
		public static Codec GetConfiguredCODECs ();
		[CCode (cname = "TIFFRGBAImageBegin")]
		public static int RGBAImageBegin (RGBAImage p1, TIFF p2, int p3, string[] p4);
		[CCode (cname = "TIFFIsCODECConfigured")]
		public static int IsCODECConfigured (ushort p1);
		[CCode (cname = "TIFFRGBAImageEnd")]
		public static void RGBAImageEnd (RGBAImage p1);
		[CCode (cname = "TIFFRGBAImageGet")]
		public static int RGBAImageGet (RGBAImage p1, out uint32[] p2, uint32 p3, uint32 p4);
		[CCode (cname = "TIFFReassignTagToIgnore")]
		public static int ReassignTagToIgnore (IgnoreSense p1, int p2);
		[CCode (cname = "TIFFRegisterCODEC")]
		public static Codec RegisterCODEC (ushort p1, string p2, InitMethod p3);
		[CCode (cname = "TIFFReverseBits")]
		public static void ReverseBits (ref uchar p1, ulong p2);
		/* *******************************************************************************
		[CCode (cname = "TIFFSetErrorHandler")]
		public static ErrorHandler SetErrorHandler (ErrorHandler p1);
		[CCode (cname = "TIFFErrorHandlerExt")]
		public static ErrorHandlerExt SetErrorHandlerExt (ErrorHandlerExt p1);
		[CCode (cname = "TIFFSetWarningHandler")]
		public static ErrorHandler SetWarningHandler (ErrorHandler p1);
		[CCode (cname = "TIFFSetWarningHandlerExt")]
		public static ErrorHandlerExt SetWarningHandlerExt (ErrorHandlerExt p1);
		******************************************************************************* */
		[CCode (cname = "TIFFSetTagExtender")]
		public static ExtendProc SetTagExtender (ExtendProc p1);
		[CCode (cname = "TIFFSwabArrayOfDouble")]
		public static void SwabArrayOfDouble (double p1, ulong p2);
		[CCode (cname = "TIFFSwabArrayOfLong")]
		public static void SwabArrayOfLong (ref uint32 p1, ulong p2);
		[CCode (cname = "TIFFSwabArrayOfShort")]
		public static void SwabArrayOfShort (ref uint16 p1, ulong p2);
		[CCode (cname = "TIFFSwabArrayOfTriples")]
		public static void SwabArrayOfTriples (uint8 p1, ulong p2);
		[CCode (cname = "TIFFSwabDouble")]
		public static void SwabDouble (double p1);
		[CCode (cname = "TIFFSwabLong")]
		public static void SwabLong (ref uint32 p1);
		[CCode (cname = "TIFFSwabShort")]
		public static void SwabShort (ref uint16 p1);
		[CCode (cname = "TIFFUnRegisterCODEC")]
		public static void UnRegisterCODEC (Codec p1);
		[CCode (cname = "TIFFWarning")]
		public static void Warning (string p1, string p2);
		[CCode (cname = "TIFFWarningExt")]
		public static void WarningExt (thandle_t p1, string p2, string p3);
		[CCode (cname = "TIFFXYZToRGB")]
		public static void XYZToRGB (ref CIELabToRGB p1, float p2, float p3, float p4, out uint32 p5, out uint32 p6, out uint32 p7);
		[CCode (cname = "TIFFYCbCrToRGBInit")]
		public static int YCbCrToRGBInit (ref YCbCrToRGB p1, ref float p2, ref float p3);
		[CCode (cname = "TIFFYCbCrtoRGB")]
		public static void YCbCrtoRGB (ref YCbCrToRGB p1, uint32 p2, int32 p3, int32 p4, out uint32 p5, out uint32 p6, out uint32 p7);
		[CCode (cname = "LogL10fromY")]
		public static int LogL10fromY (double p1, int p2);
		[CCode (cname = "LogL10toY")]
		public static double LogL10toY (int p1);
		[CCode (cname = "LogL16fromY")]
		public static int LogL16fromY (double p1, int p2);
		[CCode (cname = "LogL16toY")]
		public static double LogL16toY (int p1);
		[CCode (cname = "LogLuv24fromXYZ")]
		public static uint LogLuv24fromXYZ (float p1, int p2);
		[CCode (cname = "LogLuv24toXYZ")]
		public static void LogLuv24toXYZ (uint32 p1, float p2);
		[CCode (cname = "LogLuv32fromXYZ")]
		public static uint LogLuv32fromXYZ (float p1, int p2);
		[CCode (cname = "LogLuv32toXYZ")]
		public static void LogLuv32toXYZ (uint32 p1, float p2);
		[CCode (cname = "XYZtoRGB24")]
		public static void XYZtoRGB24 (float p1, uint8 p2);
		[CCode (cname = "uv_decode")]
		public static int uv_decode (double p1, double p2, int p3);
		[CCode (cname = "uv_encode")]
		public static int uv_encode (double p1, double p2, int p3);
	}

}

