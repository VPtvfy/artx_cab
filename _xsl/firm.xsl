<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="utf-8" indent="no" />

 <xsl:key name="idx_firm_item"     match="/nodes/firms/item" use="./firm_id" />
 <xsl:key name="idx_firm_address"  match="/nodes/firms/address" use="./firm_id" />
 <xsl:key name="idx_firm_phone"    match="/nodes/firms/phone" use="./firm_id" />

 <xsl:template name="firm_items">
     <xsl:param name="firm_id"/>
     <div><xsl:attribute name="class">firm_items</xsl:attribute>
     <xsl:for-each select="key('idx_firm_item',$firm_id)">
       <div><xsl:attribute name="class">firm_item</xsl:attribute>
            <xsl:value-of select="./item_name"/></div>
     </xsl:for-each>
     </div>
 </xsl:template>

 <xsl:template name="firm_phones">
     <xsl:param name="firm_id"/>
     <div><xsl:attribute name="class">firm_phones</xsl:attribute>
          <xsl:for-each select="key('idx_firm_phone',$firm_id)">
              <div><xsl:attribute name="class">firm_phone</xsl:attribute>
                (<xsl:value-of select="./phone_code"/>)
                <xsl:value-of select="./phone_number"/>
              </div>
          </xsl:for-each>
     </div>
 </xsl:template>

 <xsl:template name="firm_address">
     <xsl:param name="firm_id"/>
     <div><xsl:attribute name="class">address</xsl:attribute>
          <xsl:for-each select="key('idx_firm_address',$firm_id)">
              <div><xsl:attribute name="class">firm_address</xsl:attribute>
                г.<xsl:value-of select="./town_name"/>
                &#160;<xsl:value-of select="./street_name"/>
                &#160;<xsl:value-of select="./building"/>
                &#160;<xsl:value-of select="./office"/>
              </div>
          </xsl:for-each>
     </div>
 </xsl:template>

 <xsl:template name='firms'>
     <xsl:for-each select="/nodes/firms/firm">
         <div><xsl:attribute name="class">firms</xsl:attribute>
              <div><xsl:attribute name="class">firm_caption</xsl:attribute>
                  <xsl:value-of select="./firm_name"/></div>
              <xsl:call-template name="firm_phones">
                  <xsl:with-param name="firm_id" select="./firm_id"/>
              </xsl:call-template>
              <xsl:call-template name="firm_address">
                  <xsl:with-param name="firm_id" select="./firm_id"/>
              </xsl:call-template>
              <xsl:call-template name="firm_items">
                  <xsl:with-param name="firm_id" select="./firm_id"/>
              </xsl:call-template>
         </div>
     </xsl:for-each>
 </xsl:template>

</xsl:stylesheet>
