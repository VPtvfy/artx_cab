<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template name="town">
      <xsl:param name='town_id'/>
      <xsl:param name='show_all'/>
      <select name="town_id" id="town_id">
        <xsl:if test="$show_all = 1">
         <option><xsl:attribute name="value"><xsl:value-of select="0"/></xsl:attribute>Прииртышье</option>
       </xsl:if>
       <xsl:for-each select="/pageroot/towns/town">
        <option><xsl:attribute name="value"><xsl:value-of select="./id"/></xsl:attribute>
                <xsl:if test="current()/id=$town_id"><xsl:attribute name="selected"/></xsl:if>
                <xsl:value-of select="./name"/>
       </option>
      </xsl:for-each>
     </select>
</xsl:template>
</xsl:stylesheet>