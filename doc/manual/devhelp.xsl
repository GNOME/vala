<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://www.devhelp.net/book" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/">
		<book title="{//title/text()}" link="index.html" author="" name="vala" version="2">
			<chapters>
				<xsl:for-each select="//body/section">
					<sub name="{h/text()}" link="{@id}.html">
						<xsl:for-each select="section">
							<sub name="{h/text()}" link="{../@id}.html#{@id}"/>
						</xsl:for-each>
					</sub>
				</xsl:for-each>
			</chapters>
		</book>
	</xsl:template>
</xsl:stylesheet>

