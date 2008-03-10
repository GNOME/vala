#ifndef __G_REALPATH_H__
#define __G_REALPATH_H__

/**
 * g_realpath:
 *
 * this should be a) filled in for win32 and b) put in glib...
 */
	
static inline gchar*
g_realpath (const char *path)
{
	char buffer [PATH_MAX];
	if (realpath(path, buffer))
		return g_strdup(buffer);
	else
		return NULL;
}

#endif
