<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:key name="idx_firm_id"     match="/pageroot/firms/firm" use="./firm_id" />
 <xsl:key name="idx_firm_class"  match="/pageroot/firms/firm" use="concat(./firm_id,' ',./class_id)" />
 <xsl:key name="idx_firm_phone"  match="/pageroot/firms/firm" use="concat(./firm_id,' ',./phone)" />
 <xsl:key name="idx_image"       match="/pageroot/images/image" use="concat(./firm_id,' ',./type)" />

    <xsl:template name="phone">
      <xsl:if test="7> string-length($phone)">
         <xsl:if test="4 > string-length($phone)"><xsl:value-of select="$phone"/></xsl:if>
         <xsl:if test="string-length($phone) >= 4"><xsl:value-of select="substring($phone,1,2)"/>-<xsl:value-of select="substring($phone,3,2)"/>-<xsl:value-of select="substring($phone,5,2)"/></xsl:if>
      </xsl:if>
      <xsl:if test="string-length($phone) >= 7">
         <xsl:value-of select="substring($phone,1,3)"/>-<xsl:value-of select="substring($phone,4,2)"/>-<xsl:value-of select="substring($phone,6,2)"/>
      </xsl:if>
   </xsl:template>

    <xsl:template name="town_code">
     <xsl:for-each select="/pageroot/towns/town[id=$town_id]">
      <xsl:value-of select="./code" />
    </xsl:for-each>
   </xsl:template>

    <xsl:template name="firm">
     <table width="100%">
      <xsl:if test="count(/pageroot/firms/firm) > 0">
       <xsl:for-each select="/pageroot/firms/firm">
           <xsl:if test="generate-id(.) = generate-id(key('idx_firm_id',./firm_id))">
           <tr><xsl:attribute  name="bgcolor">#fdc5c6</xsl:attribute>
             <td colspan="2">
                 <a class="simple_item" href="#"><xsl:value-of  select="./firm_name"/></a>
            </td></tr>
            <tr>
            <td width="100%">
                <xsl:for-each select="key('idx_image',concat(./firm_id,' 1'))">
                     <img><xsl:attribute name="src">_ads/<xsl:value-of select="./url"/></xsl:attribute></img><br/></xsl:for-each>
                <xsl:if test="current()/subdiv !=''"><xsl:value-of  select="./subdiv"/><br/></xsl:if>
                <xsl:if test="current()/town !=''"><nobr>Адрес: г. <xsl:value-of  select="./town"/>&#160;</nobr></xsl:if><nobr>
                <xsl:if test="current()/street !=''"> ул. <xsl:value-of  select="./street"/>&#160;
                <xsl:if test="current()/building !=0"><xsl:value-of  select="./building"/>
                <xsl:if test="current()/bletter !=''">/<xsl:value-of  select="./bletter"/></xsl:if></xsl:if>
                <xsl:if test="current()/office !=0">-<xsl:value-of  select="./office"/>
                <xsl:if test="current()/oletter !=''">/<xsl:value-of  select="./oletter"/></xsl:if></xsl:if></xsl:if></nobr>
                <xsl:for-each select="key('idx_firm_id',./firm_id)">
                    <xsl:if test="generate-id(.) = generate-id(key('idx_firm_phone',concat(./firm_id,' ',./phone)))">
                    <br />
                    <xsl:if test="current()/phone > 0">(<xsl:call-template name="town_code"><xsl:with-param name="town_id" select="./town_id" /></xsl:call-template>)&#160;<xsl:call-template name="phone"><xsl:with-param name="phone" select="./phone" /></xsl:call-template></xsl:if>&#160;
                    <xsl:if test="current()/subdiv !=''"><nobr><xsl:value-of  select="./subdiv"/>&#160;</nobr></xsl:if>
                   </xsl:if>
               </xsl:for-each>
                <xsl:if test="current()/email !=''"><br/><a><xsl:attribute name="target">blank</xsl:attribute><xsl:attribute name="href">http://<xsl:value-of  select="./email"/></xsl:attribute><xsl:value-of  select="./email"/></a></xsl:if>
                <xsl:if test="current()/url !=''"><br/><a><xsl:attribute name="href">mailto:<xsl:value-of  select="./url"/></xsl:attribute><xsl:value-of  select="./url"/></a></xsl:if><hr />
                <xsl:for-each select="key('idx_firm_id',./firm_id)">
                    <xsl:if test="generate-id(.) = generate-id(key('idx_firm_class',concat(./firm_id,' ',./class_id)))">
                    <nobr><xsl:value-of  select="./class"/>.&#160;</nobr></xsl:if>
               </xsl:for-each>
            </td><td>
             <xsl:for-each select="key('idx_image',concat(./firm_id,' 2'))">
                     <img><xsl:attribute name="src">_ads/<xsl:value-of select="./url"/></xsl:attribute></img><br/></xsl:for-each>
             </td></tr>
           </xsl:if>
      </xsl:for-each>
     </xsl:if>
    </table>
 </xsl:template>
<xsl:template match="pageroot">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <link href="_css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <xsl:call-template name="firm"/>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
