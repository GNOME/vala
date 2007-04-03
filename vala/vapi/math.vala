/* math.vala - Generated from <bits/mathcalls.h> of glibc.
 *
 * Copyright (C) 2007  Mathias Hasselmann
 *
 * This library is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *
 * Author:
 *      Mathias Hasselmann <mathias.hasselmann@gmx.de>
 */

[CCode (lower_case_cprefix = "", cheader_filename = "math.h")]
namespace Math
{
	public static double acos(double x);
	public static float acosf(float x);
	public static double asin(double x);
	public static float asinf(float x);
	public static double atan(double x);
	public static float atanf(float x);
	public static double atan2(double y, double x);
	public static float atan2f(float y, float x);
	public static double cos(double x);
	public static float cosf(float x);
	public static double sin(double x);
	public static float sinf(float x);
	public static double tan(double x);
	public static float tanf(float x);
	public static double cosh(double x);
	public static float coshf(float x);
	public static double sinh(double x);
	public static float sinhf(float x);
	public static double tanh(double x);
	public static float tanhf(float x);
	public static void sincos(double x, ref double sinx, ref double cosx);
	public static void sincosf(float x, ref float sinx, ref float cosx);
	public static double acosh(double x);
	public static float acoshf(float x);
	public static double asinh(double x);
	public static float asinhf(float x);
	public static double atanh(double x);
	public static float atanhf(float x);
	public static double exp(double x);
	public static float expf(float x);
	public static double frexp(double x, ref int exponent);
	public static float frexpf(float x, ref int exponent);
	public static double ldexp(double x, int exponent);
	public static float ldexpf(float x, int exponent);
	public static double log(double x);
	public static float logf(float x);
	public static double log10(double x);
	public static float log10f(float x);
	public static double modf(double x, ref double iptr);
	public static float modff(float x, ref float iptr);
	public static double exp10(double x);
	public static float exp10f(float x);
	public static double pow10(double x);
	public static float pow10f(float x);
	public static double expm1(double x);
	public static float expm1f(float x);
	public static double log1p(double x);
	public static float log1pf(float x);
	public static double logb(double x);
	public static float logbf(float x);
	public static double exp2(double x);
	public static float exp2f(float x);
	public static double log2(double x);
	public static float log2f(float x);
	public static double pow(double x, double y);
	public static float powf(float x, float y);
	public static double sqrt(double x);
	public static float sqrtf(float x);
	public static double hypot(double x, double y);
	public static float hypotf(float x, float y);
	public static double cbrt(double x);
	public static float cbrtf(float x);
	public static double ceil(double x);
	public static float ceilf(float x);
	public static double fabs(double x);
	public static float fabsf(float x);
	public static double floor(double x);
	public static float floorf(float x);
	public static double fmod(double x, double y);
	public static float fmodf(float x, float y);
	public static int isinf(double value);
	public static int isinff(float value);
	public static int finite(double value);
	public static int finitef(float value);
	public static double drem(double x, double y);
	public static float dremf(float x, float y);
	public static double significand(double x);
	public static float significandf(float x);
	public static double copysign(double x, double y);
	public static float copysignf(float x, float y);
	public static double nan(string tagb);
	public static float nanf(string tagb);
	public static int isnan(double value);
	public static int isnanf(float value);
	public static double j0(double x0);
	public static float j0f(float x0);
	public static double j1(double x0);
	public static float j1f(float x0);
	public static double jn(int x0, double x1);
	public static float jnf(int x0, float x1);
	public static double y0(double x0);
	public static float y0f(float x0);
	public static double y1(double x0);
	public static float y1f(float x0);
	public static double yn(int x0, double x1);
	public static float ynf(int x0, float x1);
	public static double erf(double x0);
	public static float erff(float x0);
	public static double erfc(double x0);
	public static float erfcf(float x0);
	public static double lgamma(double x0);
	public static float lgammaf(float x0);
	public static double tgamma(double x0);
	public static float tgammaf(float x0);
	public static double gamma(double x0);
	public static float gammaf(float x0);
	public static double lgamma_r(double x0, ref int signgamp);
	public static float lgamma_rf(float x0, ref int signgamp);
	public static double rint(double x);
	public static float rintf(float x);
	public static double nextafter(double x, double y);
	public static float nextafterf(float x, float y);
	public static double nexttoward(double x, double y);
	public static float nexttowardf(float x, double y);
	public static double remainder(double x, double y);
	public static float remainderf(float x, float y);
	public static double scalbn(double x, int n);
	public static float scalbnf(float x, int n);
	public static int ilogb(double x);
	public static int ilogbf(float x);
	public static double scalbln(double x, long n);
	public static float scalblnf(float x, long n);
	public static double nearbyint(double x);
	public static float nearbyintf(float x);
	public static double round(double x);
	public static float roundf(float x);
	public static double trunc(double x);
	public static float truncf(float x);
	public static double remquo(double x, double y, ref int quo);
	public static float remquof(float x, float y, ref int quo);
	public static long lrint(double x);
	public static long lrintf(float x);
	public static int64 llrint(double x);
	public static int64 llrintf(float x);
	public static long lround(double x);
	public static long lroundf(float x);
	public static int64 llround(double x);
	public static int64 llroundf(float x);
	public static double fdim(double x, double y);
	public static float fdimf(float x, float y);
	public static double fmax(double x, double y);
	public static float fmaxf(float x, float y);
	public static double fmin(double x, double y);
	public static float fminf(float x, float y);
	public static double fma(double x, double y, double z);
	public static float fmaf(float x, float y, float z);
	public static double scalb(double x, double n);
	public static float scalbf(float x, float n);
}
