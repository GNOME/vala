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
        </head>
        <body>
          <div class="header">
            <a href="index.html"><xsl:value-of select="/article/section/title"/></a>
          </div>
          <xsl:apply-templates select="title"/>
          <xsl:if test="count(section) > 0">
            <ul class="page_toc">
              <xsl:for-each select="section">
                <li>
                  <xsl:call-template name="linkto">
                    <xsl:with-param name="page" select="../title"/>
                    <xsl:with-param name="subpage" select="title"/>
                    <xsl:with-param name="title" select="title"/>
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

  <xsl:template name="html5-doctype">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <xsl:call-template name="whitespace-newline"/>
  </xsl:template>

  <xsl:template match="*" mode="html5-charset">
    <xsl:text disable-output-escaping='yes'>&lt;meta charset="UTF-8" /&gt;</xsl:text>
    <xsl:call-template name="whitespace-newline"/>
  </xsl:template>

  <xsl:template name="whitespace-newline">
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="title" mode="html-head">
      <xsl:apply-templates select="." mode="html5-charset"/>
      <title><xsl:value-of select="text()"/> - <xsl:value-of select="/article/section/title"/></title>
      <link rel="stylesheet" type="text/css" href="default.css"/>
  </xsl:template>

  <xsl:template match="article">
    <xsl:apply-templates select="articleinfo|section"/>
  </xsl:template>

  <xsl:template match="article/section/title">
    <div class="header">
      <a href="index.html"><xsl:value-of select="."/></a>
    </div>
    <h1><xsl:value-of select="."/></h1>
  </xsl:template>

  <xsl:template match="article/section" mode="toc">
      <xsl:apply-templates select="title"/>
      <ul class="toc">
        <xsl:for-each select="section">
          <li>
            <xsl:call-template name="linkto">
              <xsl:with-param name="page" select="title"/>
              <xsl:with-param name="title" select="title"/>
            </xsl:call-template>
            <xsl:if test="count(section) > 0">
              <xsl:call-template name="whitespace-newline"/>
              <ul>
                <xsl:for-each select="section">
                  <li>
                    <xsl:call-template name="linkto">
                      <xsl:with-param name="page" select="../title"/>
                      <xsl:with-param name="subpage" select="title"/>
                      <xsl:with-param name="title" select="title"/>
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

  <xsl:template match="article/section/section/title">
    <h2><xsl:value-of select="."/></h2>
  </xsl:template>

  <xsl:template match="article/section/section/section">
    <xsl:apply-templates select="para|section|programlisting|screen|itemizedlist|title|informaltable"/>
  </xsl:template>

  <xsl:template match="article/section/section/section/title">
    <xsl:variable name="id">
      <xsl:call-template name="normalizepath">
        <xsl:with-param name="title" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="whitespace-newline"/>
    <xsl:call-template name="whitespace-newline"/>
    <h3 id="{$id}"><xsl:value-of select="."/></h3>
  </xsl:template>

  <xsl:template match="article/section/section/section/section">
    <xsl:apply-templates select="para|section|programlisting|screen|itemizedlist|title|informaltable"/>
  </xsl:template>

  <xsl:template match="article/section/section/section/section/title">
    <xsl:variable name="id">
      <xsl:call-template name="normalizepath">
        <xsl:with-param name="title" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <h4><xsl:value-of select="."/><a name="{$id}">&#160;</a></h4>
  </xsl:template>

  <xsl:template match="para">
    <p><xsl:apply-templates select="text()|code|ulink|emphasis"/></p>
  </xsl:template>

  <xsl:template match="emphasis">
    <strong><xsl:apply-templates select="text()"/></strong>
  </xsl:template>

  <xsl:template match="ulink">
    <xsl:if test="starts-with(@url,'http://wiki.gnome.org/Projects/Vala/Manual/Export/Projects/Vala/Manual/')">
      <xsl:variable name="pageid">
        <xsl:call-template name="normalizepath">
          <xsl:with-param name="title" select="str:decode-uri(str:tokenize(substring-after(@url, 'http://wiki.gnome.org/Projects/Vala/Manual/Export/Projects/Vala/Manual/'),'#')[1])"/>
        </xsl:call-template>
      </xsl:variable>
      <a href="{$pageid}.html#{str:tokenize(substring-after(@url, 'http://wiki.gnome.org/Projects/Vala/Manual/Export/Projects/Vala/Manual/'),'#')[2]}"><xsl:value-of select="."/></a>
    </xsl:if>
    <xsl:if test="not(starts-with(@url,'http://wiki.gnome.org/Projects/Vala/Manual/Export/Projects/Vala/Manual/'))">
      <a href="{@url}"><xsl:value-of select="."/></a>
    </xsl:if>
  </xsl:template>


  <xsl:template match="para/code">
    <xsl:if test="contains (text(), '&#x0a;')">
      <pre><xsl:value-of select="text()"/></pre>
    </xsl:if>
    <xsl:if test="not (contains (text(), '&#x0a;'))">
      <code><xsl:value-of select="text()"/></code>
    </xsl:if>
  </xsl:template>

  <xsl:template match="screen">
    <pre><xsl:value-of select="text()"/></pre>
  </xsl:template>

  <!-- program listing -->
  <xsl:template match="programlisting">
    <pre class="o-box c-program"><xsl:apply-templates select="text()|type|methodname|token|phrase|lineannotation"/></pre>
  </xsl:template>

  <xsl:template match="type">
    <span class="c-program-type"><xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="token">
    <span class="c-program-token"><xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="methodname">
    <span class="c-program-methodname"><xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="lineannotation">
    <span class="c-program-comment"><xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="phrase">
    <span class="c-program-phrase"><xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="programlisting/text()[. = '&#10;'][preceding-sibling::*[1][self::phrase]]">
    <span class="c-program-phrase"><xsl:text>\n</xsl:text></span>
  </xsl:template>

  <xsl:template match="programlisting/text()[. = '&#10;&#10;'][preceding-sibling::*[1][self::phrase]]">
    <span class="c-program-phrase"><xsl:text>\n\n</xsl:text></span>
  </xsl:template>

  <!-- lists -->
  <xsl:template match="itemizedlist[listitem[not(@override)]]">
    <ul><xsl:apply-templates select="listitem"/></ul>
  </xsl:template>

  <xsl:template match="listitem[not(@override)]">
    <li><xsl:apply-templates select="para"/></li>
  </xsl:template>

  <xsl:template match="itemizedlist[listitem[@override='none']]">
    <blockquote class="o-box c-rules"><xsl:apply-templates select="listitem"/></blockquote>
  </xsl:template>

  <xsl:template match="listitem[@override='none']/itemizedlist"><xsl:apply-templates select="listitem"/><xsl:text>
</xsl:text></xsl:template>

  <xsl:template match="listitem[@override='none']">
    <xsl:apply-templates select="para|itemizedlist"/>
  </xsl:template>

  <xsl:template match="listitem[@override='none']/para"><xsl:apply-templates select="text()|emphasis"/><xsl:text>
</xsl:text></xsl:template>

  <xsl:template match="listitem[@override='none']/para/text()">
    <xsl:if test="position()=1 and starts-with(.,' ')">
      <xsl:if test="normalize-space(.)!=''"><xsl:value-of select="substring-after(.,' ')"/></xsl:if>
    </xsl:if>
    <xsl:if test="position()!=1 or not(starts-with(.,' '))">
      <xsl:if test="normalize-space(.)!=''"><xsl:value-of select="."/></xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="listitem[@override='none']/para/emphasis[@role='strong']"><span class="literal"><xsl:value-of select="."/></span></xsl:template>
<xsl:template match="listitem[@override='none']/itemizedlist/listitem[@override='none']/para"><xsl:text>&#x09;</xsl:text><xsl:apply-templates select="text()|emphasis"/><xsl:text>
</xsl:text></xsl:template>

  <!-- tables -->
  <xsl:template match="informaltable">
    <table class="c-informaltable">
      <xsl:apply-templates select="tgroup/tbody/row"/>
    </table>
  </xsl:template>

  <xsl:template match="row">
    <tr>
      <xsl:apply-templates select="entry"/>
    </tr>
  </xsl:template>

  <xsl:template match="entry">
    <td xsl:use-attribute-sets="entry-attrs">
      <xsl:apply-templates select="para"/>
    </td>
  </xsl:template>

  <xsl:attribute-set name="entry-attrs">
    <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
    <xsl:attribute name="colspan">
      <xsl:if test="@nameend"><xsl:value-of select="number(substring-after(@nameend, 'col_'))+1"/></xsl:if>
    </xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
