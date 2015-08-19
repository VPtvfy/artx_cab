<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:key name="idx_firm_id"     match="/pageroot/firms/firm" use="./firm_id" />
 <xsl:key name="idx_firm_class"  match="/pageroot/firms/firm" use="concat(./firm_id,' ',./class_id)" />
 <xsl:key name="idx_firm_phone"  match="/pageroot/firms/firm" use="concat(./firm_id,' ',./phone)" />
 <xsl:key name="idx_image"       match="/pageroot/images/image" use="concat(./firm_id,' ',./type)" />

    <xsl:template name="phone">
      <xsl:if test="7> string-length($phone)">
         <xsl:if test="4 > string-length($phone)"><xsl:value-of select="$phone"/></xsl:if>
         <xsl:if test="string-length($phone) >= 4">
                  <!--xsl:value-of select="substring($phone,1,2)"/>-<xsl:value-of select="substring($phone,3,2)"/>-<xsl:value-of select="substring($phone,5,2)"/-->
                  <xsl:value-of select="substring($phone,1,3)"/>-<xsl:value-of select="substring($phone,4,3)"/></xsl:if>
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
     <!--table width="100%"-->
       <xsl:for-each select="/pageroot/firms/firm">
           <xsl:if test="generate-id(.) = generate-id(key('idx_firm_id',./firm_id))">
           <!--tr><xsl:attribute  name="bgcolor">#fdc5c6</xsl:attribute--><br/>
             <xsl:value-of  select="./firm_name"/><br/>
             <xsl:for-each select="key('idx_firm_id',./firm_id)">
                    <xsl:if test="generate-id(.) = generate-id(key('idx_firm_phone',concat(./firm_id,' ',./phone)))"><nobr>
                    <xsl:if test="current()/subdiv !=''"><nobr><xsl:value-of  select="./subdiv"/>&#160;</nobr></xsl:if>
                    <xsl:if test="current()/street !=''"><xsl:value-of  select="./street"/>,&#160; 
                    <xsl:if test="current()/building !=0"><xsl:value-of  select="./building"/>
                    <xsl:if test="current()/bletter !=''">/<xsl:value-of  select="./bletter"/></xsl:if></xsl:if>
                    <xsl:if test="current()/office !=0">-<xsl:value-of  select="./office"/>
                    <xsl:if test="current()/oletter !=''">/<xsl:value-of  select="./oletter"/></xsl:if></xsl:if></xsl:if></nobr><br/>
                    <xsl:if test="current()/phone > 0">...&#160;<xsl:call-template name="phone"><xsl:with-param name="phone" select="./phone" /></xsl:call-template>
                                                    </xsl:if>
                    <br/></xsl:if>
             </xsl:for-each>
           </xsl:if>
      </xsl:for-each>
    <!--/table-->
 </xsl:template>
</xsl:stylesheet>
