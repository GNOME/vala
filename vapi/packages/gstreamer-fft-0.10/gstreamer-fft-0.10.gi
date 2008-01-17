<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="fft_next_fast_length" symbol="gst_fft_next_fast_length">
			<return-type type="gint"/>
			<parameters>
				<parameter name="n" type="gint"/>
			</parameters>
		</function>
		<struct name="GstFFTF32">
			<method name="fft" symbol="gst_fft_f32_fft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTF32*"/>
					<parameter name="timedata" type="gfloat*"/>
					<parameter name="freqdata" type="GstFFTF32Complex*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_fft_f32_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTF32*"/>
				</parameters>
			</method>
			<method name="inverse_fft" symbol="gst_fft_f32_inverse_fft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTF32*"/>
					<parameter name="freqdata" type="GstFFTF32Complex*"/>
					<parameter name="timedata" type="gfloat*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_fft_f32_new">
				<return-type type="GstFFTF32*"/>
				<parameters>
					<parameter name="len" type="gint"/>
					<parameter name="inverse" type="gboolean"/>
				</parameters>
			</method>
			<method name="window" symbol="gst_fft_f32_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTF32*"/>
					<parameter name="timedata" type="gfloat*"/>
					<parameter name="window" type="GstFFTWindow"/>
				</parameters>
			</method>
			<field name="cfg" type="void*"/>
			<field name="inverse" type="gboolean"/>
			<field name="len" type="gint"/>
			<field name="_padding" type="gpointer[]"/>
		</struct>
		<struct name="GstFFTF32Complex">
			<field name="r" type="gfloat"/>
			<field name="i" type="gfloat"/>
		</struct>
		<struct name="GstFFTF64">
			<method name="fft" symbol="gst_fft_f64_fft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTF64*"/>
					<parameter name="timedata" type="gdouble*"/>
					<parameter name="freqdata" type="GstFFTF64Complex*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_fft_f64_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTF64*"/>
				</parameters>
			</method>
			<method name="inverse_fft" symbol="gst_fft_f64_inverse_fft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTF64*"/>
					<parameter name="freqdata" type="GstFFTF64Complex*"/>
					<parameter name="timedata" type="gdouble*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_fft_f64_new">
				<return-type type="GstFFTF64*"/>
				<parameters>
					<parameter name="len" type="gint"/>
					<parameter name="inverse" type="gboolean"/>
				</parameters>
			</method>
			<method name="window" symbol="gst_fft_f64_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTF64*"/>
					<parameter name="timedata" type="gdouble*"/>
					<parameter name="window" type="GstFFTWindow"/>
				</parameters>
			</method>
			<field name="cfg" type="void*"/>
			<field name="inverse" type="gboolean"/>
			<field name="len" type="gint"/>
			<field name="_padding" type="gpointer[]"/>
		</struct>
		<struct name="GstFFTF64Complex">
			<field name="r" type="gdouble"/>
			<field name="i" type="gdouble"/>
		</struct>
		<struct name="GstFFTS16">
			<method name="fft" symbol="gst_fft_s16_fft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTS16*"/>
					<parameter name="timedata" type="gint16*"/>
					<parameter name="freqdata" type="GstFFTS16Complex*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_fft_s16_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTS16*"/>
				</parameters>
			</method>
			<method name="inverse_fft" symbol="gst_fft_s16_inverse_fft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTS16*"/>
					<parameter name="freqdata" type="GstFFTS16Complex*"/>
					<parameter name="timedata" type="gint16*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_fft_s16_new">
				<return-type type="GstFFTS16*"/>
				<parameters>
					<parameter name="len" type="gint"/>
					<parameter name="inverse" type="gboolean"/>
				</parameters>
			</method>
			<method name="window" symbol="gst_fft_s16_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTS16*"/>
					<parameter name="timedata" type="gint16*"/>
					<parameter name="window" type="GstFFTWindow"/>
				</parameters>
			</method>
			<field name="cfg" type="void*"/>
			<field name="inverse" type="gboolean"/>
			<field name="len" type="gint"/>
			<field name="_padding" type="gpointer[]"/>
		</struct>
		<struct name="GstFFTS16Complex">
			<field name="r" type="gint16"/>
			<field name="i" type="gint16"/>
		</struct>
		<struct name="GstFFTS32">
			<method name="fft" symbol="gst_fft_s32_fft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTS32*"/>
					<parameter name="timedata" type="gint32*"/>
					<parameter name="freqdata" type="GstFFTS32Complex*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_fft_s32_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTS32*"/>
				</parameters>
			</method>
			<method name="inverse_fft" symbol="gst_fft_s32_inverse_fft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTS32*"/>
					<parameter name="freqdata" type="GstFFTS32Complex*"/>
					<parameter name="timedata" type="gint32*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_fft_s32_new">
				<return-type type="GstFFTS32*"/>
				<parameters>
					<parameter name="len" type="gint"/>
					<parameter name="inverse" type="gboolean"/>
				</parameters>
			</method>
			<method name="window" symbol="gst_fft_s32_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstFFTS32*"/>
					<parameter name="timedata" type="gint32*"/>
					<parameter name="window" type="GstFFTWindow"/>
				</parameters>
			</method>
			<field name="cfg" type="void*"/>
			<field name="inverse" type="gboolean"/>
			<field name="len" type="gint"/>
			<field name="_padding" type="gpointer[]"/>
		</struct>
		<struct name="GstFFTS32Complex">
			<field name="r" type="gint32"/>
			<field name="i" type="gint32"/>
		</struct>
		<enum name="GstFFTWindow">
			<member name="GST_FFT_WINDOW_RECTANGULAR" value="0"/>
			<member name="GST_FFT_WINDOW_HAMMING" value="1"/>
			<member name="GST_FFT_WINDOW_HANN" value="2"/>
			<member name="GST_FFT_WINDOW_BARTLETT" value="3"/>
			<member name="GST_FFT_WINDOW_BLACKMAN" value="4"/>
		</enum>
	</namespace>
</api>
