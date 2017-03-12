<?xml version="1.0"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.1"
  xmlns="http://www.devhelp.net/book"
  >

  <xsl:import href="common.xsl"/>

  <xsl:output
    method="xml"
    indent="yes"
  />

  <xsl:template match="/">
    <book title="{/article/section/title/text()}" link="index.html" author="" name="vala" language="vala" version="2">
      <chapters>
        <xsl:apply-templates select="/article/section/section"/>
      </chapters>
    </book>
  </xsl:template>

  <xsl:template match="/article/section/section">
    <xsl:variable name="path">
      <xsl:call-template name="normalizepath">
        <xsl:with-param name="title" select="title"/>
      </xsl:call-template>
    </xsl:variable>
    <sub name="{title/text()}" link="{$path}.html">
      <xsl:for-each select="section">
        <xsl:variable name="fragment">
          <xsl:call-template name="normalizepath">
            <xsl:with-param name="title" select="title"/>
          </xsl:call-template>
        </xsl:variable>
        <sub name="{title/text()}" link="{$path}.html#{$fragment}"/>
      </xsl:for-each>
    </sub>
  </xsl:template>

</xsl:stylesheet>

