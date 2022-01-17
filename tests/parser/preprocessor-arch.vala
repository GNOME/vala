/*
 x86_64
 i386
 ppc64el
 ppc
 aarch64
 arm
 sparc64
 sparc
 mips64
 mips
 alpha
 hppa1
 hppa2
 m68k
 s390x
*/
void main () {
#if VALA_ARCH_X86_64
	assert (sizeof (void*) == 8);
	assert (sizeof (int) == 4);
	assert (sizeof (uint8) == 1);
	assert (sizeof (uint16) == 2);
	assert (sizeof (uint32) == 4);
	assert (sizeof (size_t) == 8);
	assert (sizeof (ssize_t) == 8);
	assert (sizeof (uint64) == 8);
	assert (sizeof (int64) == 8);
#elif VALA_ARCH_I386
	assert (sizeof (void*) == 4);
	assert (sizeof (int) == 4);
	assert (sizeof (uint8) == 1);
	assert (sizeof (uint16) == 2);
	assert (sizeof (uint32) == 4);
	assert (sizeof (size_t) == 4);
	assert (sizeof (ssize_t) == 4);
	assert (sizeof (uint64) == 8);
	assert (sizeof (int64) == 8);
#elif VALA_ARCH_PPC64EL
#elif VALA_ARCH_PPC
#elif VALA_ARCH_AARCH64
#elif VALA_ARCH_ARM
#elif VALA_ARCH_SPARC64
#elif VALA_ARCH_SPARC
#elif VALA_ARCH_MIPS64
#elif VALA_ARCH_MIPS
#elif VALA_ARCH_ALPHA
#elif VALA_ARCH_HPPA1
#elif VALA_ARCH_HPPA2
#elif VALA_ARCH_M68K
#elif VALA_ARCH_S390X
#else
	message ("Targeting an unkown arch");
#endif
}
