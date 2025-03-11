<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="param1"></xsl:param>
    <xsl:param name="param2"></xsl:param>
    <xsl:param name="param3"></xsl:param>
    <xsl:template match="/">
        <html>
            <body>
                <h2>My CD Collection</h2>
                <h3>
                    <xsl:value-of select="$param3"/>
                </h3>
                <h4>My Rating - <xsl:value-of select="$param2"/></h4>
                <table border="1">
                    <tr bgcolor="#9acd32">
                        <th style="text-align:left">Title</th>
                        <th style="text-align:left">Artist</th>
                    </tr>
                    <xsl:for-each select="catalog/cd">
                        <tr>
                            <td><xsl:value-of select="title"/></td>
                            <td><xsl:value-of select="artist"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
