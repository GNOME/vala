<?xml version="1.0"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:str="http://exslt.org/strings"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="str"
>

  <xsl:import href="common.xsl"/>

  <xsl:output
    method="html"
    indent="yes"
    omit-xml-declaration="yes"
    encoding="UTF-8"
    media-type="text/html"
  />

  <xsl:param name="body-class"></xsl:param>

  <xsl:template match="/">
    <xsl:call-template name="html5-doctype"/>
    <html><xsl:call-template name="whitespace-newline"/>
    <head><xsl:call-template name="whitespace-newline"/>
    <xsl:call-template name="html-no-initial-scaling"/>
    <xsl:apply-templates select="article/section/title[1]" mode="html-head"/>
    </head><xsl:call-template name="whitespace-newline"/>
    <body>
    <xsl:if test="$body-class != ''">
      <xsl:attribute name="class"><xsl:value-of select="$body-class"/></xsl:attribute>
    </xsl:if>
    <xsl:call-template name="whitespace-newline"/>
    <xsl:apply-templates select="/article/section/title" mode="navigation-bar"/>
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
    <exsl:document
      href="{$path}.html"
      method="html"
      indent="yes"
      omit-xml-declaration="yes"
    >
      <xsl:call-template name="html5-doctype"/>
      <html>
        <head>
        <xsl:apply-templates select="title" mode="html-head"/>
        <xsl:call-template name="html-no-initial-scaling"/>
        </head>
        <body>
        <xsl:if test="$body-class != ''">
          <xsl:attribute name="class"><xsl:value-of select="$body-class"/></xsl:attribute>
        </xsl:if>
          <xsl:apply-templates
            select="title"
            mode="navigation-bar"
          />
          <xsl:apply-templates select="title" mode="heading"/>
          <xsl:if test="count(section) > 0">
            <ul class="page_toc">
              <xsl:for-each select="section">
                <li>
                  <xsl:call-template name="linkto">
                    <xsl:with-param name="title">
                      <xsl:apply-templates select="title" mode="numbered-level-two"/>
                    </xsl:with-param>
                    <xsl:with-param name="page" select="../title"/>
                    <xsl:with-param name="subpage" select="title"/>
                  </xsl:call-template>
                </li>
              </xsl:for-each>
            </ul>
          </xsl:if>
          <xsl:apply-templates select="para|section|programlisting|screen|itemizedlist"/>
        </body>
      </html>
    </exsl:document>
  </xsl:template>

  <xsl:template match="title" mode="navigation-bar">
    <div class="o-fixedtop c-navbar">
      <div class="o-navbar">
      <xsl:if test="$body-class != ''">
        <xsl:attribute name="class">o-navbar <xsl:value-of select="$body-class"/></xsl:attribute>
      </xsl:if>
      <span class="c-pageturner u-float-left"><a href="index.html">Contents</a></span>
      <span><xsl:value-of select="/article/section/title"/></span>
      <div class="u-float-right">
      <span class="c-pageturner o-inlinewidth-4"><xsl:call-template name="navigation-bar-prev"/></span>
      <span class="c-pageturner o-inlinewidth-4"><xsl:call-template name="navigation-bar-next"/></span>
      </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="navigation-bar-prev">
    <xsl:choose>
      <xsl:when test="parent::section/preceding::section[1]/title">
        <xsl:call-template name="linkto">
          <xsl:with-param name="title">Prev</xsl:with-param>
          <xsl:with-param name="page" select="parent::section/preceding-sibling::section[1]/title"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="parent::section[1]/parent::section/title">
        <a href="index.html">Prev</a>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="navigation-bar-next">
    <xsl:choose>
      <xsl:when test="parent::section/parent::article/section/section[1]/title|parent::section/following::section[1]/title">
        <xsl:call-template name="linkto">
          <xsl:with-param name="title">Next</xsl:with-param>
          <xsl:with-param name="page" select="parent::section/parent::article/section/section[1]/title|parent::section/following::section[1]/title"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <span></span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
