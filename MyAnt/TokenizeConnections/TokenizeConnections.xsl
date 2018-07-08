<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sp="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:adf="http://oracle.com/adf" xmlns="http://xmlns.oracle.com/adf/jndi" exclude-result-prefixes="sp adf" version="1.0">
	<xsl:strip-space elements="References"/>
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="EdgeApplication">
		<xsl:apply-templates select="Reference"/>
	</xsl:template>
	<xsl:template match="Reference">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="wsconnection">
		<xsl:variable name="edgeAppName">
			<xsl:value-of select="../../../../../@name"/>
			<xsl:value-of select="'WSCTEST'"/>
		</xsl:variable>
		<xsl:variable name="tokenizeCtx">
			<xsl:value-of select="../../../../../@tokenizeCtx"/>
		</xsl:variable>
		<xsl:element name="wsconnection">
			<xsl:variable name="url">
				<xsl:value-of select="current()/@description"/>
			</xsl:variable>
			<xsl:attribute name="description">
				<xsl:value-of select="concat($edgeAppName,'PROTOCOL')"/>
				<xsl:value-of select="'://'"/>
				<xsl:value-of select="concat($edgeAppName,'HOST',':',$edgeAppName,'PORT','/')"/>
				<xsl:choose>
					<xsl:when test="$tokenizeCtx='true'">
						<xsl:value-of select="concat($edgeAppName,'CTX','/')"/>
						<xsl:value-of select="substring-after(substring-after(substring-after(substring-after($url,'/'),'/'),'/'),'/')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring-after(substring-after(substring-after($url,'/'),'/'),'/')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="service">
				<xsl:value-of select="current()/@service"/>
			</xsl:attribute>
			<xsl:apply-templates select="node()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="adf:policy-references">
		<xsl:variable name="edgeAppName">
			<xsl:value-of select="'SAMPLE_EDGE_APP'"/>
		</xsl:variable>
		
				<xsl:variable name="uri">
					<xsl:value-of select="current()/@uri"/>
				</xsl:variable>
				<xsl:variable name="id">
					<xsl:value-of select="current()/@id"/>
				</xsl:variable>
				<xsl:element name="policy-references" namespace="http://oracle.com/adf">
				<xsl:element name="policy-reference" namespace="">
					<xsl:attribute name="category">
						<xsl:value-of select="'security'"/>
					</xsl:attribute>
					<xsl:attribute name="enabled">
						<xsl:value-of select="'true'"/>
					</xsl:attribute>
					<xsl:attribute name="uri">
						<xsl:value-of select="concat($edgeAppName,'POLICY')"/>
					</xsl:attribute>
					<xsl:attribute name="id">
						<xsl:value-of select="concat($edgeAppName,'ID')"/>
					</xsl:attribute>
					<!--<xsl:apply-templates select="node()"/> -->
				</xsl:element>
				</xsl:element>
			
		
	</xsl:template>
	<xsl:template match="sp:soap">
		<xsl:variable name="edgeAppName">
			<xsl:value-of select="../../../../../../../../../@name"/>
			<xsl:value-of select="'SOAPTEST'"/>
		</xsl:variable>
		<xsl:variable name="tokenizeCtx">
			<xsl:value-of select="../../../../../../../../../@tokenizeCtx"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="current()/@addressUrl">
				<xsl:variable name="url">
					<xsl:value-of select="current()/@addressUrl"/>
				</xsl:variable>
				<xsl:element name="soap" namespace="http://schemas.xmlsoap.org/wsdl/soap/">
					<xsl:attribute name="addressUrl">
						<xsl:value-of select="concat($edgeAppName,'PROTOCOL')"/>
						<xsl:value-of select="'://'"/>
						<xsl:value-of select="concat($edgeAppName,'HOST',':',$edgeAppName,'PORT','/')"/>
						<xsl:choose>
							<xsl:when test="$tokenizeCtx='true'">
								<xsl:value-of select="concat($edgeAppName,'CTX','/')"/>
								<xsl:value-of select="substring-after(substring-after(substring-after(substring-after($url,'/'),'/'),'/'),'/')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring-after(substring-after(substring-after($url,'/'),'/'),'/')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates select="node()"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*|node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="urlconnection">
		<xsl:variable name="edgeAppName">
			<xsl:value-of select="../../../../../@name"/>
		</xsl:variable>
		<xsl:variable name="tokenizeCtx">
			<xsl:value-of select="../../../../../@tokenizeCtx"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="current()/@url">
				<xsl:variable name="url">
					<xsl:value-of select="current()/@url"/>
				</xsl:variable>
				<xsl:variable name="name1">
					<xsl:value-of select="current()/@name"/>
				</xsl:variable>
				<xsl:element name="urlconnection">
					<xsl:attribute name="name">
						<xsl:value-of select="$name1"/>
					</xsl:attribute>
					<xsl:attribute name="url">
						<xsl:value-of select="concat($edgeAppName,'PROTOCOL')"/>
						<xsl:value-of select="'://'"/>
						<xsl:value-of select="concat($edgeAppName,'HOST',':',$edgeAppName,'PORT','/')"/>
						<xsl:choose>
							<xsl:when test="$tokenizeCtx='true'">
								<xsl:value-of select="concat($edgeAppName,'CTX','/')"/>
								<xsl:value-of select="substring-after(substring-after(substring-after(substring-after($url,'/'),'/'),'/'),'/')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring-after(substring-after(substring-after($url,'/'),'/'),'/')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates select="node()"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*|node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
