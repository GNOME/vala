<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="riff_create_audio_caps" symbol="gst_riff_create_audio_caps">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="codec_id" type="guint16"/>
				<parameter name="strh" type="gst_riff_strh*"/>
				<parameter name="strf" type="gst_riff_strf_auds*"/>
				<parameter name="strf_data" type="GstBuffer*"/>
				<parameter name="strd_data" type="GstBuffer*"/>
				<parameter name="codec_name" type="char**"/>
			</parameters>
		</function>
		<function name="riff_create_audio_template_caps" symbol="gst_riff_create_audio_template_caps">
			<return-type type="GstCaps*"/>
		</function>
		<function name="riff_create_iavs_caps" symbol="gst_riff_create_iavs_caps">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="codec_fcc" type="guint32"/>
				<parameter name="strh" type="gst_riff_strh*"/>
				<parameter name="strf" type="gst_riff_strf_iavs*"/>
				<parameter name="strf_data" type="GstBuffer*"/>
				<parameter name="strd_data" type="GstBuffer*"/>
				<parameter name="codec_name" type="char**"/>
			</parameters>
		</function>
		<function name="riff_create_iavs_template_caps" symbol="gst_riff_create_iavs_template_caps">
			<return-type type="GstCaps*"/>
		</function>
		<function name="riff_create_video_caps" symbol="gst_riff_create_video_caps">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="codec_fcc" type="guint32"/>
				<parameter name="strh" type="gst_riff_strh*"/>
				<parameter name="strf" type="gst_riff_strf_vids*"/>
				<parameter name="strf_data" type="GstBuffer*"/>
				<parameter name="strd_data" type="GstBuffer*"/>
				<parameter name="codec_name" type="char**"/>
			</parameters>
		</function>
		<function name="riff_create_video_template_caps" symbol="gst_riff_create_video_template_caps">
			<return-type type="GstCaps*"/>
		</function>
		<function name="riff_init" symbol="gst_riff_init">
			<return-type type="void"/>
		</function>
		<function name="riff_parse_chunk" symbol="gst_riff_parse_chunk">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="offset" type="guint*"/>
				<parameter name="fourcc" type="guint32*"/>
				<parameter name="chunk_data" type="GstBuffer**"/>
			</parameters>
		</function>
		<function name="riff_parse_file_header" symbol="gst_riff_parse_file_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="doctype" type="guint32*"/>
			</parameters>
		</function>
		<function name="riff_parse_info" symbol="gst_riff_parse_info">
			<return-type type="void"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="taglist" type="GstTagList**"/>
			</parameters>
		</function>
		<function name="riff_parse_strf_auds" symbol="gst_riff_parse_strf_auds">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="strf" type="gst_riff_strf_auds**"/>
				<parameter name="data" type="GstBuffer**"/>
			</parameters>
		</function>
		<function name="riff_parse_strf_iavs" symbol="gst_riff_parse_strf_iavs">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="strf" type="gst_riff_strf_iavs**"/>
				<parameter name="data" type="GstBuffer**"/>
			</parameters>
		</function>
		<function name="riff_parse_strf_vids" symbol="gst_riff_parse_strf_vids">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="strf" type="gst_riff_strf_vids**"/>
				<parameter name="data" type="GstBuffer**"/>
			</parameters>
		</function>
		<function name="riff_parse_strh" symbol="gst_riff_parse_strh">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="strh" type="gst_riff_strh**"/>
			</parameters>
		</function>
		<function name="riff_read_chunk" symbol="gst_riff_read_chunk">
			<return-type type="GstFlowReturn"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="offset" type="guint64*"/>
				<parameter name="tag" type="guint32*"/>
				<parameter name="chunk_data" type="GstBuffer**"/>
			</parameters>
		</function>
		<struct name="gst_riff_acid">
			<field name="loop_type" type="guint32"/>
			<field name="root_note" type="guint16"/>
			<field name="unknown1" type="guint16"/>
			<field name="unknown2" type="gfloat"/>
			<field name="number_of_beats" type="guint32"/>
			<field name="meter_d" type="guint16"/>
			<field name="meter_n" type="guint16"/>
			<field name="tempo" type="gfloat"/>
		</struct>
		<struct name="gst_riff_dmlh">
			<field name="totalframes" type="guint32"/>
		</struct>
		<struct name="gst_riff_index_entry">
			<field name="id" type="guint32"/>
			<field name="flags" type="guint32"/>
			<field name="offset" type="guint32"/>
			<field name="size" type="guint32"/>
		</struct>
		<struct name="gst_riff_strf_auds">
			<field name="format" type="guint16"/>
			<field name="channels" type="guint16"/>
			<field name="rate" type="guint32"/>
			<field name="av_bps" type="guint32"/>
			<field name="blockalign" type="guint16"/>
			<field name="size" type="guint16"/>
		</struct>
		<struct name="gst_riff_strf_iavs">
			<field name="DVAAuxSrc" type="guint32"/>
			<field name="DVAAuxCtl" type="guint32"/>
			<field name="DVAAuxSrc1" type="guint32"/>
			<field name="DVAAuxCtl1" type="guint32"/>
			<field name="DVVAuxSrc" type="guint32"/>
			<field name="DVVAuxCtl" type="guint32"/>
			<field name="DVReserved1" type="guint32"/>
			<field name="DVReserved2" type="guint32"/>
		</struct>
		<struct name="gst_riff_strf_vids">
			<field name="size" type="guint32"/>
			<field name="width" type="guint32"/>
			<field name="height" type="guint32"/>
			<field name="planes" type="guint16"/>
			<field name="bit_cnt" type="guint16"/>
			<field name="compression" type="guint32"/>
			<field name="image_size" type="guint32"/>
			<field name="xpels_meter" type="guint32"/>
			<field name="ypels_meter" type="guint32"/>
			<field name="num_colors" type="guint32"/>
			<field name="imp_colors" type="guint32"/>
		</struct>
		<struct name="gst_riff_strh">
			<field name="type" type="guint32"/>
			<field name="fcc_handler" type="guint32"/>
			<field name="flags" type="guint32"/>
			<field name="priority" type="guint32"/>
			<field name="init_frames" type="guint32"/>
			<field name="scale" type="guint32"/>
			<field name="rate" type="guint32"/>
			<field name="start" type="guint32"/>
			<field name="length" type="guint32"/>
			<field name="bufsize" type="guint32"/>
			<field name="quality" type="guint32"/>
			<field name="samplesize" type="guint32"/>
		</struct>
		<constant name="GST_RIFF_IBM_FORMAT_ADPCM" type="int" value="259"/>
		<constant name="GST_RIFF_IBM_FORMAT_ALAW" type="int" value="258"/>
		<constant name="GST_RIFF_IBM_FORMAT_MULAW" type="int" value="257"/>
		<constant name="GST_RIFF_IF_COMPUSE" type="int" value="268369920"/>
		<constant name="GST_RIFF_IF_KEYFRAME" type="int" value="16"/>
		<constant name="GST_RIFF_IF_LIST" type="int" value="1"/>
		<constant name="GST_RIFF_IF_NO_TIME" type="int" value="256"/>
		<constant name="GST_RIFF_STRH_DISABLED" type="int" value="1"/>
		<constant name="GST_RIFF_STRH_VIDEOPALCHANGES" type="int" value="65536"/>
		<constant name="GST_RIFF_WAVE_FORMAT_A52" type="int" value="8192"/>
		<constant name="GST_RIFF_WAVE_FORMAT_AAC" type="int" value="255"/>
		<constant name="GST_RIFF_WAVE_FORMAT_AAC_AC" type="int" value="16707"/>
		<constant name="GST_RIFF_WAVE_FORMAT_AAC_pm" type="int" value="28781"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ADPCM" type="int" value="2"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ADPCM_IMA_DK3" type="int" value="98"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ADPCM_IMA_DK4" type="int" value="97"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ADPCM_IMA_WAV" type="int" value="105"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ALAW" type="int" value="6"/>
		<constant name="GST_RIFF_WAVE_FORMAT_AMR_NB" type="int" value="87"/>
		<constant name="GST_RIFF_WAVE_FORMAT_AMR_WB" type="int" value="88"/>
		<constant name="GST_RIFF_WAVE_FORMAT_APTX" type="int" value="37"/>
		<constant name="GST_RIFF_WAVE_FORMAT_AUDIOFILE_AF10" type="int" value="38"/>
		<constant name="GST_RIFF_WAVE_FORMAT_AUDIOFILE_AF36" type="int" value="36"/>
		<constant name="GST_RIFF_WAVE_FORMAT_BTV_DIGITAL" type="int" value="1024"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CANOPUS_ATRAC" type="int" value="99"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CIRRUS" type="int" value="96"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CONTROL_RES_CR10" type="int" value="55"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CONTROL_RES_VQLPC" type="int" value="52"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CREATIVE_ADPCM" type="int" value="512"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CREATIVE_FASTSPEECH10" type="int" value="515"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CREATIVE_FASTSPEECH8" type="int" value="514"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CS2" type="int" value="608"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CS_IMAADPCM" type="int" value="57"/>
		<constant name="GST_RIFF_WAVE_FORMAT_CU_CODEC" type="int" value="25"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DF_G726" type="int" value="133"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DF_GSM610" type="int" value="134"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DIALOGIC_OKI_ADPCM" type="int" value="23"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DIGIADPCM" type="int" value="54"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DIGIFIX" type="int" value="22"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DIGIREAL" type="int" value="53"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DIGISTD" type="int" value="21"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DIGITAL_G723" type="int" value="291"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DOLBY_AC2" type="int" value="48"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DOLBY_AC3_SPDIF" type="int" value="146"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DSAT_DISPLAY" type="int" value="103"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DSP_TRUESPEECH" type="int" value="34"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DTS" type="int" value="8193"/>
		<constant name="GST_RIFF_WAVE_FORMAT_DVI_ADPCM" type="int" value="17"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ECHOSC1" type="int" value="35"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ECHOSC3" type="int" value="58"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ESPCM" type="int" value="97"/>
		<constant name="GST_RIFF_WAVE_FORMAT_EXTENSIBLE" type="int" value="65534"/>
		<constant name="GST_RIFF_WAVE_FORMAT_FLAC" type="int" value="61868"/>
		<constant name="GST_RIFF_WAVE_FORMAT_FM_TOWNS_SND" type="int" value="768"/>
		<constant name="GST_RIFF_WAVE_FORMAT_G722_ADPCM" type="int" value="101"/>
		<constant name="GST_RIFF_WAVE_FORMAT_G723_ADPCM" type="int" value="20"/>
		<constant name="GST_RIFF_WAVE_FORMAT_G726ADPCM" type="int" value="320"/>
		<constant name="GST_RIFF_WAVE_FORMAT_G726_ADPCM" type="int" value="100"/>
		<constant name="GST_RIFF_WAVE_FORMAT_G728_CELP" type="int" value="65"/>
		<constant name="GST_RIFF_WAVE_FORMAT_G729A" type="int" value="131"/>
		<constant name="GST_RIFF_WAVE_FORMAT_GSM610" type="int" value="49"/>
		<constant name="GST_RIFF_WAVE_FORMAT_GSM_AMR_CBR" type="int" value="31265"/>
		<constant name="GST_RIFF_WAVE_FORMAT_GSM_AMR_VBR" type="int" value="31266"/>
		<constant name="GST_RIFF_WAVE_FORMAT_IBM_CVSD" type="int" value="5"/>
		<constant name="GST_RIFF_WAVE_FORMAT_IEEE_FLOAT" type="int" value="3"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ILINK_VC" type="int" value="560"/>
		<constant name="GST_RIFF_WAVE_FORMAT_IMC" type="int" value="1025"/>
		<constant name="GST_RIFF_WAVE_FORMAT_IPI_HSX" type="int" value="592"/>
		<constant name="GST_RIFF_WAVE_FORMAT_IPI_RPELP" type="int" value="593"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ISIAUDIO" type="int" value="136"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ITU_G721_ADPCM" type="int" value="64"/>
		<constant name="GST_RIFF_WAVE_FORMAT_LH_CODEC" type="int" value="4352"/>
		<constant name="GST_RIFF_WAVE_FORMAT_LRC" type="int" value="40"/>
		<constant name="GST_RIFF_WAVE_FORMAT_LUCENT_G723" type="int" value="89"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MALDEN_PHONYTALK" type="int" value="160"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MEDIASONIC_G723" type="int" value="147"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MEDIASPACE_ADPCM" type="int" value="18"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MEDIAVISION_ADPCM" type="int" value="24"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MPEGL12" type="int" value="80"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MPEGL3" type="int" value="85"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MSG723" type="int" value="66"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MSN" type="int" value="50"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MSRT24" type="int" value="130"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MULAW" type="int" value="7"/>
		<constant name="GST_RIFF_WAVE_FORMAT_MVI_MVI2" type="int" value="132"/>
		<constant name="GST_RIFF_WAVE_FORMAT_NMS_VBXADPCM" type="int" value="56"/>
		<constant name="GST_RIFF_WAVE_FORMAT_NORRIS" type="int" value="5120"/>
		<constant name="GST_RIFF_WAVE_FORMAT_OKI_ADPCM" type="int" value="16"/>
		<constant name="GST_RIFF_WAVE_FORMAT_OLIADPCM" type="int" value="4097"/>
		<constant name="GST_RIFF_WAVE_FORMAT_OLICELP" type="int" value="4098"/>
		<constant name="GST_RIFF_WAVE_FORMAT_OLIGSM" type="int" value="4096"/>
		<constant name="GST_RIFF_WAVE_FORMAT_OLIOPR" type="int" value="4100"/>
		<constant name="GST_RIFF_WAVE_FORMAT_OLISBC" type="int" value="4099"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ONLIVE" type="int" value="137"/>
		<constant name="GST_RIFF_WAVE_FORMAT_PAC" type="int" value="83"/>
		<constant name="GST_RIFF_WAVE_FORMAT_PACKED" type="int" value="153"/>
		<constant name="GST_RIFF_WAVE_FORMAT_PCM" type="int" value="1"/>
		<constant name="GST_RIFF_WAVE_FORMAT_PHILIPS_LPCBB" type="int" value="152"/>
		<constant name="GST_RIFF_WAVE_FORMAT_PROSODY_1612" type="int" value="39"/>
		<constant name="GST_RIFF_WAVE_FORMAT_PROSODY_8KBPS" type="int" value="148"/>
		<constant name="GST_RIFF_WAVE_FORMAT_QDESIGN_MUSIC" type="int" value="1104"/>
		<constant name="GST_RIFF_WAVE_FORMAT_QUALCOMM_HALFRATE" type="int" value="337"/>
		<constant name="GST_RIFF_WAVE_FORMAT_QUALCOMM_PUREVOICE" type="int" value="336"/>
		<constant name="GST_RIFF_WAVE_FORMAT_QUARTERDECK" type="int" value="544"/>
		<constant name="GST_RIFF_WAVE_FORMAT_RAW_SPORT" type="int" value="576"/>
		<constant name="GST_RIFF_WAVE_FORMAT_RHETOREX_ADPCM" type="int" value="256"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ROCKWELL_ADPCM" type="int" value="59"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ROCKWELL_DIGITALK" type="int" value="60"/>
		<constant name="GST_RIFF_WAVE_FORMAT_RT24" type="int" value="82"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SANYO_LD_ADPCM" type="int" value="293"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SBC24" type="int" value="145"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SIERRA_ADPCM" type="int" value="19"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SIPROLAB_ACELP4800" type="int" value="305"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SIPROLAB_ACELP8V3" type="int" value="306"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SIPROLAB_ACEPLNET" type="int" value="304"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SIPROLAB_G729" type="int" value="307"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SIPROLAB_G729A" type="int" value="308"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SIPROLAB_KELVIN" type="int" value="309"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SIREN" type="int" value="654"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SOFTSOUND" type="int" value="128"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SONARC" type="int" value="33"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SONIC" type="int" value="8264"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SONIC_LS" type="int" value="8264"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SONY_ATRAC3" type="int" value="624"/>
		<constant name="GST_RIFF_WAVE_FORMAT_SOUNDSPACE_MUSICOMPRESS" type="int" value="5376"/>
		<constant name="GST_RIFF_WAVE_FORMAT_TPC" type="int" value="1665"/>
		<constant name="GST_RIFF_WAVE_FORMAT_TUBGSM" type="int" value="341"/>
		<constant name="GST_RIFF_WAVE_FORMAT_UHER_ADPCM" type="int" value="528"/>
		<constant name="GST_RIFF_WAVE_FORMAT_UNKNOWN" type="int" value="0"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VIVO_G723" type="int" value="273"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VIVO_SIREN" type="int" value="274"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VME_VMPCM" type="int" value="1664"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VORBIS1" type="int" value="26447"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VORBIS1PLUS" type="int" value="26479"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VORBIS2" type="int" value="26448"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VORBIS2PLUS" type="int" value="26480"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VORBIS3" type="int" value="26449"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VORBIS3PLUS" type="int" value="26481"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE" type="int" value="98"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_AC10" type="int" value="113"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_AC16" type="int" value="114"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_AC20" type="int" value="115"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_AC8" type="int" value="112"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_BYTE_ALIGNED" type="int" value="105"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_METASOUND" type="int" value="117"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_METAVOICE" type="int" value="116"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_RT29HW" type="int" value="118"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_TQ40" type="int" value="121"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_TQ60" type="int" value="129"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_VR12" type="int" value="119"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VOXWARE_VR18" type="int" value="120"/>
		<constant name="GST_RIFF_WAVE_FORMAT_VSELP" type="int" value="4"/>
		<constant name="GST_RIFF_WAVE_FORMAT_WMAV1" type="int" value="352"/>
		<constant name="GST_RIFF_WAVE_FORMAT_WMAV2" type="int" value="353"/>
		<constant name="GST_RIFF_WAVE_FORMAT_WMAV3" type="int" value="354"/>
		<constant name="GST_RIFF_WAVE_FORMAT_WMAV3_L" type="int" value="355"/>
		<constant name="GST_RIFF_WAVE_FORMAT_WMS" type="int" value="10"/>
		<constant name="GST_RIFF_WAVE_FORMAT_XEBEC" type="int" value="61"/>
		<constant name="GST_RIFF_WAVE_FORMAT_YAMAHA_ADPCM" type="int" value="32"/>
		<constant name="GST_RIFF_WAVE_FORMAT_ZYXEL_ADPCM" type="int" value="151"/>
	</namespace>
</api>
