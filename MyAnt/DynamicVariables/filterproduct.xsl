<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:strip-space elements="product"/>
	<xsl:output omit-xml-declaration="yes" indent="yes"/>
	<xsl:key name="patchNo" match="patch" use="node()"/>
	<xsl:param name="productName"/>
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="patch">
		<xsl:choose>
			<xsl:when test="generate-id()=generate-id(key('patchNo', node())[1])">
				<xsl:copy-of select="."/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="product">
		<xsl:variable name="matchedNode" select="."/>
		<xsl:if test="$matchedNode/@name = $productName">
			<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
