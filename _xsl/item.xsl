<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:key name="idx_item_id"    match="/nodes/catalog/item" use="./item_id" />
 <xsl:key name="idx_item_pid"   match="/nodes/catalog/item" use="./item_pid" />

 <xsl:template name="alphaindex">
      <xsl:for-each select="/nodes/catalog/alpha">
           <span>
             <a><xsl:attribute name="href">alpha=<xsl:value-of select="./sym"/></xsl:attribute>
                <xsl:attribute name="target">#result_cat</xsl:attribute>
                <xsl:value-of select="./sym"/>
             </a></span>
     </xsl:for-each>
 </xsl:template>
<!-- Item parent
-->
 <xsl:template name="item_path">
     <xsl:param name="item_id"/>
     <xsl:if test="$item_id>0">
         <xsl:call-template name="item_path">
             <xsl:with-param name="item_id" select="key('idx_item_id',$item_id)/item_pid"/>
         </xsl:call-template> ->
     </xsl:if>
     <xsl:for-each select="key('idx_item_id',$item_id)">
         <xsl:call-template name="item"/>
     </xsl:for-each>
 </xsl:template>

 <xsl:template name="item">
     <a><xsl:attribute name="title"><xsl:value-of  select="./item_name"/></xsl:attribute>
        <xsl:if test="./stat != 0">
            <xsl:attribute name="target">#result_firm</xsl:attribute>
            <xsl:attribute name="href">find&amp;item=<xsl:value-of  select="./item_id"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="./stat = 0">
            <xsl:attribute name="target">#result_cat</xsl:attribute>
            <xsl:attribute name="href">item=<xsl:value-of  select="./item_id"/></xsl:attribute>
        </xsl:if>
        <xsl:value-of  select="./item_name"/></a>
 </xsl:template>

 <xsl:template name="items" match="/nodes/catalog/item">
     <xsl:param name='item_id'/>
     <div><xsl:call-template name="item_path">
              <xsl:with-param name="item_id" select="$item_id" />
         </xsl:call-template></div>
     <ul>
     <xsl:for-each select="key('idx_item_pid',$item_id)">
         <xsl:if test="./item_id != ./item_pid">
             <li><xsl:call-template name="item"/></li>
         </xsl:if>
     </xsl:for-each>
     </ul>
  </xsl:template>
</xsl:stylesheet>