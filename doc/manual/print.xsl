<?xml version="1.0"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:str="http://exslt.org/strings"
  xmlns:exsl="http://exslt.org/common"
  xmlns:date="http://exslt.org/dates-and-times"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="str date"
>

  <xsl:import href="common.xsl"/>

  <xsl:output
    method="html"
    indent="yes"
    omit-xml-declaration="yes"
    encoding="UTF-8"
    media-type="text/html"
  />

  <xsl:template match="/">
    <xsl:call-template name="html5-doctype"/>
    <html><xsl:call-template name="whitespace-newline"/>
    <head><xsl:call-template name="whitespace-newline"/>
    <xsl:apply-templates select="article/section/title[1]" mode="html-head"/>
    </head><xsl:call-template name="whitespace-newline"/>
    <body><xsl:call-template name="whitespace-newline"/>
    <xsl:apply-templates select="article" mode="toc"/>
    </body><xsl:call-template name="whitespace-newline"/>
    </html>
  </xsl:template>

  <xsl:template match="article/section/section">
    <xsl:variable name="path">
      <xsl:call-template name="normalizepath">
        <xsl:with-param name="title" select="title"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="title" mode="heading"/>
    <xsl:if test="count(section) > 0">
      <ul class="page_toc">
        <xsl:for-each select="section">
          <li>
            <xsl:call-template name="linkto">
              <xsl:with-param name="title">
                <xsl:apply-templates select="title" mode="numbered-level-two"/>
              </xsl:with-param>
              <xsl:with-param name="page" select="''"/>
              <xsl:with-param name="subpage" select="concat( ../title, '_', title )"/>
            </xsl:call-template>
          </li>
        </xsl:for-each>
      </ul>
    </xsl:if>
    <xsl:apply-templates select="para|section|programlisting|screen|itemizedlist"/>
  </xsl:template>

  <xsl:template match="article/section" mode="toc">
      <h1><xsl:apply-templates select="title"/></h1>
      <xsl:apply-templates select="document('version.xml')/articleinfo" mode="toc"/>
      <ul class="toc">
        <xsl:for-each select="section">
          <li>
            <xsl:call-template name="linkto">
              <xsl:with-param name="title">
                <xsl:apply-templates select="title" mode="numbered-level-one"/>
              </xsl:with-param>
              <xsl:with-param name="page" select="''"/>
              <xsl:with-param name="subpage" select="title"/>
            </xsl:call-template>
            <xsl:if test="count(section) > 0">
              <xsl:call-template name="whitespace-newline"/>
              <ul>
                <xsl:for-each select="section">
                  <li>
                    <xsl:call-template name="linkto">
                      <xsl:with-param name="title">
                        <xsl:apply-templates select="title" mode="numbered-level-two"/>
                      </xsl:with-param>
                      <xsl:with-param name="page" select="''"/>
                      <xsl:with-param name="subpage" select="concat( ../title, '_', title )"/>
                    </xsl:call-template>
                  </li>
                </xsl:for-each>
              </ul>
            </xsl:if>
          </li>
        </xsl:for-each>
      </ul>
      <xsl:apply-templates select="section"/>
  </xsl:template>

  <xsl:template match="article/section/section/title" mode="heading">
    <xsl:variable name="id">
      <xsl:call-template name="normalizepath">
        <xsl:with-param name="title" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="whitespace-newline"/>
    <xsl:call-template name="whitespace-newline"/>
    <h2 id="{$id}"><xsl:apply-templates select="." mode="numbered-level-one"/></h2>
  </xsl:template>

  <xsl:template match="article/section/section/section/title">
    <xsl:variable name="id">
      <xsl:call-template name="normalizepath">
        <xsl:with-param name="title" select="concat( ../../title, '_', . )"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="whitespace-newline"/>
    <xsl:call-template name="whitespace-newline"/>
    <h3 id="{$id}"><xsl:apply-templates select="." mode="numbered-level-two"/></h3>
  </xsl:template>

  <xsl:template match="ulink">
    <xsl:if test="starts-with(@url,'https://wiki.gnome.org/Projects/Vala/Manual/Export/Projects/Vala/Manual/')">
      <xsl:variable name="pageid">
        <xsl:call-template name="normalizepath">
          <xsl:with-param name="title" select="str:decode-uri(str:tokenize(substring-after(@url, 'https://wiki.gnome.org/Projects/Vala/Manual/Export/Projects/Vala/Manual/'),'#')[1])"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
      <xsl:when test="substring-after(@url, '#') = ''">
      <a href="#{$pageid}"><xsl:value-of select="."/></a>
      </xsl:when>
      <xsl:otherwise>
      <a href="#{$pageid}_{str:tokenize(substring-after(@url, 'https://wiki.gnome.org/Projects/Vala/Manual/Export/Projects/Vala/Manual/'),'#')[2]}"><xsl:value-of select="."/></a>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="not(starts-with(@url,'https://wiki.gnome.org/Projects/Vala/Manual/Export/Projects/Vala/Manual/'))">
      <a href="{@url}"><xsl:value-of select="."/></a>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>

