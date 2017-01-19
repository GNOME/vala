<?xml version="1.0"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:str="http://exslt.org/strings"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="str"
>

  <xsl:template name="normalizepath">
    <xsl:param name="title"/>
    <xsl:variable name="space-to-underscore" select="str:replace($title, ' ', '_')"/>
    <xsl:variable name="open-parens-to-underscore" select="str:replace($space-to-underscore, '(', '_')"/>
    <xsl:value-of select="str:replace($open-parens-to-underscore, ')', '_')"/>
  </xsl:template>

  <xsl:template name="linkto">
    <xsl:param name="page"/>
    <xsl:param name="subpage"/>
    <xsl:param name="title"/>
    <xsl:variable name="path">
      <xsl:call-template name="normalizepath">
        <xsl:with-param name="title" select="$page"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="fragment">
      <xsl:call-template name="normalizepath">
        <xsl:with-param name="title" select="$subpage"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$fragment=''">
      <a href="{$path}.html"><xsl:value-of select="$title"/></a>
      </xsl:when>
      <xsl:otherwise>
      <a href="{$path}.html#{$fragment}"><xsl:value-of select="$title"/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
