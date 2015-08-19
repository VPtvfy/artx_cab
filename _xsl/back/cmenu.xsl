<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template name="menuitems">
      <xsl:param name='pid'/>
      <xsl:param name='show_all'/>
      <select name="citem_id" id="citem_form">
       <xsl:call-template name="menuitem">
           <xsl:with-param name="pid" select="$pid" />
           <xsl:with-param name="show_all" select="$show_all" />
      </xsl:call-template>
     </select>
 </xsl:template>
    <xsl:template name="menuitem">
      <xsl:param name='pid'/>
      <xsl:param name='show_all'/>
       <xsl:if test="$show_all=1">
            <option><xsl:attribute name="value">0</xsl:attribute>---</option>
      </xsl:if>
       <xsl:for-each select="/pageroot/catalog/item">
              <xsl:if test="./id > 0 "><!--and ./count=0-->
                   <option><xsl:attribute name="value"><xsl:value-of select="./id"/></xsl:attribute>
                    <xsl:if test="current()/id=$pid"><xsl:attribute name="selected"/></xsl:if>
                    <xsl:value-of select="./data"/>&#160;[<xsl:value-of select="./stat"/>]
                  </option>
             </xsl:if>
      </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
