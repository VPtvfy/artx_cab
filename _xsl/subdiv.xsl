<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:key name="idx_firm_id"     match="/pageroot/firms/firm"   use="./firm_id" />
 <xsl:key name="idx_firm_class"  match="/pageroot/firms/firm"   use="concat(./firm_id,' ',./class_id)" />
 <xsl:key name="idx_firm_phone"  match="/pageroot/firms/firm"   use="concat(./firm_id,' ',./phone)" />
 <xsl:key name="idx_image"       match="/pageroot/images/image" use="concat(./firm_id,' ',./type)" />

    <xsl:template name="phone">
     <xsl:param name='phone'/>
      <xsl:if test="7> string-length($phone)">
         <xsl:if test="4 > string-length($phone)"><xsl:value-of select="$phone"/></xsl:if>
         <xsl:if test="string-length($phone) >= 4"><xsl:value-of select="substring($phone,1,2)"/>-<xsl:value-of select="substring($phone,3,2)"/>-<xsl:value-of select="substring($phone,5,2)"/></xsl:if>
      </xsl:if>
      <xsl:if test="string-length($phone) >= 7">
         <xsl:value-of select="substring($phone,1,3)"/>-<xsl:value-of select="substring($phone,4,2)"/>-<xsl:value-of select="substring($phone,6,2)"/>
      </xsl:if>
   </xsl:template>

    <xsl:template name="town_code">
     <xsl:param name='town_id'/>
     <xsl:for-each select="/pageroot/towns/town[id=$town_id]">
      <xsl:value-of select="./code" />
    </xsl:for-each>
   </xsl:template>

    <xsl:template name="adress">
      <xsl:if test="current()/town !=''"><nobr>Адрес: г. <xsl:value-of  select="./town"/>&#160;</nobr></xsl:if><nobr>
      <xsl:if test="current()/street !=''"> ул. <xsl:value-of  select="./street"/>&#160;
      <xsl:if test="current()/building !=0"><xsl:value-of  select="./building"/>
      <xsl:if test="current()/bletter !=''">/<xsl:value-of  select="./bletter"/></xsl:if></xsl:if>
      <xsl:if test="current()/office !=0">-<xsl:value-of  select="./office"/>
      <xsl:if test="current()/oletter !=''">/<xsl:value-of  select="./oletter"/></xsl:if></xsl:if></xsl:if></nobr>
   </xsl:template>

    <xsl:template name="firm">
     <xsl:param name='pid'/>
     <form action="new_firm.php" target="firm" method="post" name="ffirm" id="ffirm">
       <input type="hidden" name="firm_id" id="firm_id"/></form>
     <table width="100%">
      <xsl:if test="count(/pageroot/firms/firm) > 0">
       <xsl:for-each select="/pageroot/firms/firm">
           <xsl:if test="generate-id(.) = generate-id(key('idx_firm_id',./firm_id))">
           <tr><xsl:attribute  name="bgcolor">#fdc5c6</xsl:attribute>
             <td colspan="2"><a href="#"><xsl:attribute name="OnClick">javascript:if(firms<xsl:value-of select="./subdiv_id"/>.style.display!="none"){firms<xsl:value-of select="./subdiv_id"/>.style.display="none";firmd<xsl:value-of select="./subdiv_id"/>.style.display="block"} else {firms<xsl:value-of select="./subdiv_id"/>.style.display="block";firmd<xsl:value-of select="./subdiv_id"/>.style.display="none"};return false;</xsl:attribute>
                 <xsl:if test ="/pageroot/var/all_vip != 1"><img border="0" src="_img/x.gif" />&#160;</xsl:if></a>
                 <a class="simple_item" href="#"><xsl:attribute name="OnClick">javascript:firm=window.open("./empty.html","firm","width=524, height=600, scrollbars");document.all.firm_id.value=<xsl:value-of select="./firm_id"/>;document.all.ffirm.submit();return false;</xsl:attribute><xsl:value-of  select="./firm_name"/></a>
                 <xsl:for-each select="key('idx_image',concat(./firm_id,' 3'))">
                 <a><xsl:attribute name="href">_ads/<xsl:value-of select="./url"/></xsl:attribute>
                    <xsl:attribute name="class">active_item</xsl:attribute>
                    <xsl:attribute name="target">blank</xsl:attribute>&#160;&#160;&#160;* INFO *</a><br/></xsl:for-each>
            </td></tr>
            <xsl:if test ="/pageroot/var/all_vip != 1">
                <tr><xsl:attribute name="id">firms<xsl:value-of select="./subdiv_id"/></xsl:attribute><xsl:if test ="./vip=1 or /pageroot/var/all_vip=1"><xsl:attribute name="class">invisible</xsl:attribute></xsl:if>
                <td><nobr><xsl:value-of  select="substring(./subdiv,1,32)"/><xsl:if test="string-length(current()/subdiv)>32">...</xsl:if></nobr>
                    <xsl:if test="current()/phone > 0"><nobr>&#160;т.&#160;<xsl:call-template name="phone"><xsl:with-param name="phone" select="./phone" /></xsl:call-template></nobr></xsl:if>
                    -&#160;<nobr><xsl:value-of  select="./class"/></nobr>
                </td></tr></xsl:if>
            <tr><xsl:attribute name="id">firmd<xsl:value-of select="./subdiv_id"/></xsl:attribute>
                 <xsl:if test ="./vip!=1 and /pageroot/var/all_vip!=1"><xsl:attribute name="class">invisible</xsl:attribute></xsl:if>
            <td width="100%">
                <xsl:for-each select="key('idx_image',concat(./firm_id,' 1'))">
                     <img><xsl:attribute name="src">_ads/<xsl:value-of select="./url"/></xsl:attribute></img><br/></xsl:for-each>
                <xsl:if test="current()/subdiv !=''"><xsl:value-of  select="./subdiv"/><br/></xsl:if>
                <xsl:call-template name="adress"/>
                <!--xsl:for-each select="key('idx_firm_id',./firm_id)">
                    <xsl:if test="generate-id(.) = generate-id(key('idx_firm_phone',concat(./firm_id,' ',./phone)))"></xsl:if>
                </xsl:for-each-->
                <xsl:if test="current()/email !=''"><br/><a><xsl:attribute name="target">blank</xsl:attribute><xsl:attribute name="href">http://<xsl:value-of  select="./email"/></xsl:attribute><xsl:value-of  select="./email"/></a></xsl:if>
                <xsl:if test="current()/url !=''"><br/><a><xsl:attribute name="href">mailto:<xsl:value-of  select="./url"/></xsl:attribute><xsl:value-of  select="./url"/></a></xsl:if><hr />
                <xsl:for-each select="key('idx_firm_id',./firm_id)">
                    <xsl:if test="generate-id(.) = generate-id(key('idx_firm_class',concat(./firm_id,' ',./class_id)))">
                    <span><xsl:value-of  select="./class"/></span>.&#160;</xsl:if>
               </xsl:for-each>
            </td><td>
             <xsl:for-each select="key('idx_image',concat(./firm_id,' 2'))">
                     <img><xsl:attribute name="src">_ads/<xsl:value-of select="./url"/></xsl:attribute></img><br/></xsl:for-each>
             </td></tr>
           </xsl:if>
      </xsl:for-each>
     </xsl:if>
     <xsl:if test="count(/pageroot/firms/firm) = 0 and /pageroot/var/find_str !=''">
        <tr><td>Ничего не найдено<br/><xsl:if test="$pid>0">
                Вы искали <a href="#"><xsl:value-of select="/pageroot/var/find_str"/></a>
                в рубрике <xsl:call-template name='item'><xsl:with-param name="pid" select="/pageroot/var/class_id"/></xsl:call-template></xsl:if>
            </td></tr>
     </xsl:if>
    </table>
 </xsl:template>
</xsl:stylesheet>
