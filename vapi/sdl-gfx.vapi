using GLib;
using SDL;

namespace SDLGraphics {
	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Pixel {
		[CCode (cname="pixelColor")]
		public static int color(Surface dst, int16 x, int16 y, uint32 color);

		[CCode (cname="pixelRGBA")]
		public static int rgba(Surface dst, int16 x, int16 y, 
			uchar r, uchar g, uchar b, uchar a);
	}// Pixel

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Line {
		[CCode (cname="hlineColor")]
		public static int color_h(Surface dst, int16 x1, int16 x2, 
			int16 y, uint32 color);

		[CCode (cname="hlineRGBA")]
		public static int rgba_h(Surface dst, int16 x1, int16 x2, 
			int16 y, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="vlineColor")]
		public static int color_v(Surface dst, int16 x, int16 y1, 
			int16 y2, uint32 color);

		[CCode (cname="vlineRGBA")]
		public static int rgba_v(Surface dst, int16 x, int16 y1, 
			int16 y2, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="lineColor")]
		public static int color(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, uint32 color);

		[CCode (cname="lineRGBA")]
		public static int rgba(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="aalineColor")]
		public static int color_aa(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, uint32 color);

		[CCode (cname="aalineRGBA")]
		public static int rgba_aa(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, uchar r, uchar g, uchar b, uchar a);
	}// Line

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Rectangle {
		[CCode (cname="rectangleColor")]
		public static int outline_color(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, uint32 color);

		[CCode (cname="rectangleRGBA")]
		public static int outline_rgba(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="boxColor")]
		public static int fill_color(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, uint32 color);

		[CCode (cname="boxRGBA")]
		public static int fill_rgba(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, uchar r, uchar g, uchar b, uchar a);
	}// Rectangle

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Circle {
		[CCode (cname="circleColor")]
		public static int outline_color(Surface dst, int16 x, int16 y, 
			int16 radius, uint32 color);

		[CCode (cname="circleRGBA")]
		public static int outline_rgba(Surface dst, int16 x, int16 y, int16 radius, 
			uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="aacircleColor")]
		public static int outline_color_aa(Surface dst, int16 x, int16 y, 
			int16 radius, uint32 color);

		[CCode (cname="aacircleRGBA")]
		public static int outline_rgba_aa(Surface dst, int16 x, int16 y, int16 radius, 
			uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="filledCircleColor")]
		public static int fill_color(Surface dst, int16 x, int16 y, 
			int16 radius, uint32 color);

		[CCode (cname="filledCircleRGBA")]
		public static int fill_rgba(Surface dst, int16 x, int16 y, int16 radius, 
			uchar r, uchar g, uchar b, uchar a);
	}// Circle

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Ellipse {
		[CCode (cname="ellipseColor")]
		public static int outline_color(Surface dst, int16 xc, int16 yc, 
			int16 rx, int16 ry, uint32 color);

		[CCode (cname="ellipseRGBA")]
		public static int outline_rgba(Surface dst, int16 xc, int16 yc, 
			int16 rx, int16 ry, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="aaellipseColor")]
		public static int outline_color_aa(Surface dst, int16 xc, int16 yc, 
			int16 rx, int16 ry, uint32 color);

		[CCode (cname="aaellipseRGBA")]
		public static int outline_rgba_aa(Surface dst, int16 xc, int16 yc, 
			int16 rx, int16 ry, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="filledEllipseColor")]
		public static int fill_color(Surface dst, int16 xc, int16 yc, 
			int16 rx, int16 ry, uint32 color);

		[CCode (cname="filledEllipseRGBA")]
		public static int fill_rgba(Surface dst, int16 xc, int16 yc, 
			int16 rx, int16 ry, uchar r, uchar g, uchar b, uchar a);
	}// Ellipse

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Arc {
		[CCode (cname="pieColor")]
		public static int outline_color(Surface dst, int16 x, int16 y, int16 radius, 
			int16 start, int16 end, uint32 color);

		[CCode (cname="pieRGBA")]
		public static int outline_rgba(Surface dst, int16 x, int16 y, int16 radius, 
			int16 start, int16 end, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="filledPieColor")]
		public static int fill_color(Surface dst, int16 x, int16 y, int16 radius, 
			int16 start, int16 end, uint32 color);

		[CCode (cname="filledPieRGBA")]
		public static int fill_rgba(Surface dst, int16 x, int16 y, int16 radius, 
			int16 start, int16 end, uchar r, uchar g, uchar b, uchar a);
	}// Arc

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Trigon {
		[CCode (cname="trigonColor")]
		public static int outline_color(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, int16 x3, int16 y3, uint32 color);

		[CCode (cname="trigonRGBA")]
		public static int outline_rgba(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, int16 x3, int16 y3, 
			uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="aatrigonColor")]
		public static int outline_color_aa(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, int16 x3, int16 y3, uint32 color);

		[CCode (cname="aatrigonRGBA")]
		public static int outline_rgba_aa(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, int16 x3, int16 y3, 
			uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="filledTrigonColor")]
		public static int fill_color(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, int16 x3, int16 y3, uint32 color);

		[CCode (cname="filledTrigonRGBA")]
		public static int fill_rgba(Surface dst, int16 x1, int16 y1, 
			int16 x2, int16 y2, int16 x3, int16 y3, 
			uchar r, uchar g, uchar b, uchar a);
	}// Trigon

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Polygon {
		[CCode (cname="polygonColor")]
		[NoArrayLength]
		public static int outline_color(Surface dst, int16[] vx, int16[] vy, 
			int n, uint32 color);

		[CCode (cname="polygonRGBA")]
		[NoArrayLength]
		public static int outline_rgba(Surface dst, int16[] vx, int16[] vy, 
			int n, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="aapolygonColor")]
		[NoArrayLength]
		public static int outline_color_aa(Surface dst, int16[] vx, int16[] vy, 
			int n, uint32 color);

		[CCode (cname="aapolygonRGBA")]
		[NoArrayLength]
		public static int outline_rgba_aa(Surface dst, int16[] vx, int16[] vy, 
			int n, uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="filledPolygonColor")]
		[NoArrayLength]
		public static int fill_color(Surface dst, int16[] vx, int16[] vy, 
			int n, uint32 color);

		[CCode (cname="filledPolygonRGBA")]
		[NoArrayLength]
		public static int fill_rgba(Surface dst, int16[] vx, int16[] vy, 
			int n, uchar r, uchar g, uchar b, uchar a);
	}// Polygon

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class BezierCurve {
		[CCode (cname="bezierColor")]
		[NoArrayLength]
		public static int color(Surface dst, int16[] vx, int16[] vy, 
			int vertices, int steps, uint32 color);

		[CCode (cname="bezierRGBA")]
		[NoArrayLength]
		public static int rgba(Surface dst, int16[] vx, int16[] vy, 
			int vertices, int steps, uchar r, uchar g, uchar b, uchar a);
	}// BezierCurve

	[CCode (cheader_filename="SDL_gfxPrimitives.h")]
	public class Text {
		[CCode (cname="stringColor")]
		public static int color(Surface dst, int16 x, int16 y, string s, uint32 color);

		[CCode (cname="stringRGBA")]
		public static int rgba(Surface dst, int16 x, int16 y, string s, 
			uchar r, uchar g, uchar b, uchar a);

		[CCode (cname="gfxPrimitivesSetFont")]
		public static int set_font(pointer fontdata, int cw, int ch);
	}// Text

	[CCode (cheader_filename="SDL_rotozoom.h")]
	public class RotoZoom {
		[CCode (cname="rotozoomSurface")]
		public static Surface rotozoom(Surface src, double degrees, 
			double zoom, int smooth);

		[CCode (cname="rotozoomSurfaceXY")]
		public static Surface rotozoom_xy(Surface src, double degrees, 
			double zoomx, double zoomy, int smooth);

		[CCode (cname="rotozoomSurfaceSize")]
		public static void rotozoom_size(int width, int height, double degrees, 
			double zoom, ref int dstwidth, ref int dstheight);

		[CCode (cname="rotozoomSurfaceSizeXY")]
		public static void rotozoom_size_xy(int width, int height, double degrees, 
			double zoomx, double zoomy, ref int dstwidth, ref int dstheight);

		[CCode (cname="zoomSurface")]
		public static Surface zoom(Surface src, double zoomx, 
			double zoomy, int smooth);

		[CCode (cname="zoomSurfaceSize")]
		public static void zoom_size(int width, int height, double zoomx, 
			double zoomy, ref int dstwidth, ref int dstheight);
	}// RotoZoom

	[CCode (cheader_filename="SDL_framerate.h", cname="FPSmanager", free_function="g_free")]
	public class FramerateManager {
		[CCode (cname="SDL_initFramerate")]
		public void init();

		[CCode (cname="SDL_setFramerate")]
		public int set_rate(int rate);

		[CCode (cname="SDL_getFramerate")]
		public int get_rate();

		[CCode (cname="SDL_framerateDelay")]
		public void run();
	}// FramerateManager

	[CCode (cheader_filename="SDL_imageFilter.h")]
	public class Filter {
		[CCode (cname="SDL_imageFilterMMXdetect")]
		public static int have_mmx();

		[CCode (cname="SDL_imageFilterMMXon")]
		public static void enable_mmx();

		[CCode (cname="SDL_imageFilterMMXoff")]
		public static void disable_mmx();

		[CCode (cname="SDL_imageFilterAdd")]
		[NoArrayLength]
		public static int add(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterMean")]
		[NoArrayLength]
		public static int mean(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterSub")]
		[NoArrayLength]
		public static int subtract(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterAbsDiff")]
		[NoArrayLength]
		public static int absolute_difference(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterMult")]
		[NoArrayLength]
		public static int multiply(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterMultNor")]
		[NoArrayLength]
		public static int multiply_normalized(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterMultDivby2")]
		[NoArrayLength]
		public static int multiply_half(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterMultDivby4")]
		[NoArrayLength]
		public static int multiply_quarter(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterBitAnd")]
		[NoArrayLength]
		public static int and(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterBitOr")]
		[NoArrayLength]
		public static int or(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterDiv")]
		[NoArrayLength]
		public static int divide(uchar[] src1, uchar[] src2, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterBitNegation")]
		[NoArrayLength]
		public static int negate(uchar[] src1, uchar[] dst, int length);

		[CCode (cname="SDL_imageFilterAddByte")]
		[NoArrayLength]
		public static int add_uchar(uchar[] src1, uchar[] dst, int length, uchar addend);

		[CCode (cname="SDL_imageFilterAddUint")]
		[NoArrayLength]
		public static int add_uint(uchar[] src1, uchar[] dst, int length, uint addend);

		[CCode (cname="SDL_imageFilterAddByteToHalf")]
		[NoArrayLength]
		public static int halve_add_uchar(uchar[] src1, uchar[] dst, int length, uchar addend);

		[CCode (cname="SDL_imageFilterSubByte")]
		[NoArrayLength]
		public static int subtract_uchar(uchar[] src1, uchar[] dst, int length, uchar subtrahend);

		[CCode (cname="SDL_imageFilterSubUint")]
		[NoArrayLength]
		public static int subtract_uint(uchar[] src1, uchar[] dst, int length, uint subtrahend);

		[CCode (cname="SDL_imageFilterShiftRight")]
		[NoArrayLength]
		public static int shift_right_uchar(uchar[] src1, uchar[] dst, int length, uchar shiftcount);

		[CCode (cname="SDL_imageFilterShiftRightUint")]
		[NoArrayLength]
		public static int shift_right_uint(uchar[] src1, uchar[] dst, int length, uint shiftcount);

		[CCode (cname="SDL_imageFilterMultByByte")]
		[NoArrayLength]
		public static int multiply_uchar(uchar[] src1, uchar[] dst, int length, uchar multiplicand);

		[CCode (cname="SDL_imageFilterShiftRightAndMultByByte")]
		[NoArrayLength]
		public static int shift_right_multiply_uchar(uchar[] src1, uchar[] dst, int length, uchar shiftcount, uchar multiplicand);

		[CCode (cname="SDL_imageFilterShiftLeftByte")]
		[NoArrayLength]
		public static int shift_left_uchar(uchar[] src1, uchar[] dst, int length, uchar shiftcount);

		[CCode (cname="SDL_imageFilterShiftLeftUint")]
		[NoArrayLength]
		public static int shift_left_uint(uchar[] src1, uchar[] dst, int length, uint shiftcount);

		[CCode (cname="SDL_imageFilterBinarizeUsingThreshold")]
		[NoArrayLength]
		public static int binarize(uchar[] src1, uchar[] dst, int length, uchar threshold);

		[CCode (cname="SDL_imageFilterClipToRange")]
		[NoArrayLength]
		public static int clip(uchar[] src1, uchar[] dst, int length, uchar min, uchar max);

		[CCode (cname="SDL_imageFilterNormalize")]
		[NoArrayLength]
		public static int normalize(uchar[] src1, uchar[] dst, int length, int cmin, int cmax, int nmin, int nmax);

		[CCode (cname="SDL_imageFilterConvolveKernel3x3Divide")]
		[NoArrayLength]
		public static int convolve_3x3_divide(uchar[] src1, uchar[] dst, int rows, int columns, int16[] kernel, uchar divisor);

		[CCode (cname="SDL_imageFilterConvolveKernel5x5Divide")]
		[NoArrayLength]
		public static int convolve_5x5_divide(uchar[] src1, uchar[] dst, int rows, int columns, int16[] kernel, uchar divisor);

		[CCode (cname="SDL_imageFilterConvolveKernel7x7Divide")]
		[NoArrayLength]
		public static int convolve_7x7_divide(uchar[] src1, uchar[] dst, int rows, int columns, int16[] kernel, uchar divisor);

		[CCode (cname="SDL_imageFilterConvolveKernel9x9Divide")]
		[NoArrayLength]
		public static int convolve_9x9_divide(uchar[] src1, uchar[] dst, int rows, int columns, int16[] kernel, uchar divisor);

		[CCode (cname="SDL_imageFilterConvolveKernel3x3ShiftRight")]
		[NoArrayLength]
		public static int convolve_3x3_shift(uchar[] src1, uchar[] dst, int rows, int columns, int16[] kernel, uchar shiftcount);

		[CCode (cname="SDL_imageFilterConvolveKernel5x5ShiftRight")]
		[NoArrayLength]
		public static int convolve_5x5_shift(uchar[] src1, uchar[] dst, int rows, int columns, int16[] kernel, uchar shiftcount);

		[CCode (cname="SDL_imageFilterConvolveKernel7x7ShiftRight")]
		[NoArrayLength]
		public static int convolve_7x7_shift(uchar[] src1, uchar[] dst, int rows, int columns, int16[] kernel, uchar shiftcount);

		[CCode (cname="SDL_imageFilterConvolveKernel9x9ShiftRight")]
		[NoArrayLength]
		public static int convolve_9x9_shift(uchar[] src1, uchar[] dst, int rows, int columns, int16[] kernel, uchar shiftcount);

		[CCode (cname="SDL_imageFilterSobelX")]
		[NoArrayLength]
		public static int sobel(uchar[] src1, uchar[] dst, int rows, int columns);

		[CCode (cname="SDL_imageFilterSobelXShiftRight")]
		[NoArrayLength]
		public static int sobel_shift(uchar[] src1, uchar[] dst, int rows, int columns, uchar shiftcount);
	}// Filter
}// SDLGraphics
