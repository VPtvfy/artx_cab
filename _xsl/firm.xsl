<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:key name="idx_firm_item"     match="/nodes/firms/item"    use="./firm_id" />
<xsl:key name="idx_firm_phone"    match="/nodes/firms/phone"   use="./address_id" />
<xsl:key name="idx_firm_address"  match="/nodes/firms/address" use="./firm_id" />

 <xsl:template name="firm_items">
     <xsl:param name="firm_id"/>
     <div><xsl:attribute name="class">firm_items</xsl:attribute>
     <xsl:for-each select="key('idx_firm_item',$firm_id)">
       <div><xsl:attribute name="class">firm_item</xsl:attribute>            
            <a><xsl:attribute name="href">pic_item&amp;item_id=<xsl:value-of select="./item_id"/></xsl:attribute>
               <xsl:value-of select="./item_name"/></a></div>
     </xsl:for-each>
     </div>
 </xsl:template>

 <xsl:template name="firm_phones">
     <xsl:param name="address_id"/>
     <!--div><xsl:attribute name="class">firm_phones</xsl:attribute-->
          <xsl:for-each select="key('idx_firm_phone',$address_id)">
              <div><xsl:attribute name="class">firm_phone</xsl:attribute>
                  <xsl:if test='./phone_code!=""'>(<xsl:value-of select="./phone_code"/>)</xsl:if>
                  <a><xsl:attribute name="title"><xsl:value-of select="./phone_description"/></xsl:attribute>
                     <xsl:value-of select="./phone_number"/></a>
              </div>
          </xsl:for-each>
     <!--/div-->
 </xsl:template>

 <xsl:template name="firm_phones_ctrl">
     <xsl:param name="address_id"/>
     <!--div><xsl:attribute name="class">firm_phones</xsl:attribute-->
          <xsl:for-each select="key('idx_firm_phone',$address_id)">
              <div><xsl:attribute name="class">firm_phone</xsl:attribute>
                  <xsl:if test='./phone_code!=""'>(<xsl:value-of select="./phone_code"/>)</xsl:if>
                  <a><xsl:attribute name="title"><xsl:value-of select="./phone_description"/></xsl:attribute>
                     <xsl:value-of select="./phone_number"/></a>
              </div>
          </xsl:for-each>
          <input>
             <xsl:attribute name="name">new_phone</xsl:attribute>
             <xsl:attribute name="placeholder">(XXXX)XXXXXX : Описание</xsl:attribute>
          </input>
     <!--/div-->
 </xsl:template>

 <xsl:template name="firm_address">
     <xsl:param name="firm_id"/>
     <div><xsl:attribute name="class">address</xsl:attribute>
          <xsl:for-each select="key('idx_firm_address',$firm_id)">
              <div>
                  <xsl:call-template name="firm_phones">
                      <xsl:with-param name="address_id" select="./address_id"/>
                  </xsl:call-template>
                  <div><xsl:attribute name="class">firm_address</xsl:attribute>
                       <a><xsl:attribute name="title"><xsl:value-of select="./description"/></xsl:attribute>
                          г.<xsl:value-of select="./town_name"/>
                          &#160;<xsl:value-of select="./street_name"/>
                          &#160;<xsl:value-of select="./building"/>
                          &#160;<xsl:value-of select="./office"/>
                       </a>
                  </div>
              </div>
          </xsl:for-each>
     </div>
 </xsl:template>

 <xsl:template name="firm_address_ctrl">
     <xsl:param name="firm_id"/>
     <div><xsl:attribute name="class">address</xsl:attribute>
          <xsl:for-each select="key('idx_firm_address',$firm_id)">
              <form>
                 <fieldset>
                    <legend>
                          г.<xsl:value-of select="./town_name"/>
                          &#160;<xsl:value-of select="./street_name"/>
                          &#160;<xsl:value-of select="./building"/>
                          &#160;<xsl:value-of select="./office"/>
                    </legend>
                      <xsl:call-template name="firm_phones_ctrl">
                          <xsl:with-param name="address_id" select="./address_id"/>
                      </xsl:call-template>
                 </fieldset>
              </form>
          </xsl:for-each>
     </div>
 </xsl:template>

 <xsl:template name='firms'>
     <div><xsl:attribute name="id">result_firm</xsl:attribute>
          <xsl:for-each select="/nodes/firms/firm">
              <div><xsl:attribute name="class">firms</xsl:attribute>
                   <div><xsl:attribute name="class">firm_caption</xsl:attribute>
                         <a><xsl:attribute name="title"><xsl:value-of select="./firm_id"/>&#160;<xsl:value-of select="./firm_descr"/></xsl:attribute>
                          <xsl:value-of select="./firm_name"/></a></div>
                   <xsl:call-template name="firm_address">
                       <xsl:with-param name="firm_id" select="./firm_id"/>
                   </xsl:call-template>
                   <xsl:call-template name="firm_items">
                       <xsl:with-param name="firm_id" select="./firm_id"/>
                   </xsl:call-template>
              </div>
          </xsl:for-each>
     </div>
 </xsl:template>

</xsl:stylesheet>
