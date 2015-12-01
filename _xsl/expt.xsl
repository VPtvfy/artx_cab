<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="export_form_items">
         <select>
           <xsl:attribute name="id">export_item</xsl:attribute>
           <xsl:attribute name="name">export_item_id</xsl:attribute>
           <xsl:for-each select="/nodes/catalog/item">
               <option><xsl:attribute name="value"><xsl:value-of select='item_id'/></xsl:attribute>
                       <xsl:if test="/state/export_item_id=./item_id"><xsl:attribute name="selected"/></xsl:if>
                       <xsl:value-of select='item_name'/> : <xsl:value-of select='stat'/></option>
           </xsl:for-each>
         </select>
</xsl:template>
<!--
-->
<xsl:template name="export_form">
    <div><xsl:attribute name="id">export_form</xsl:attribute>
         <form>
         <input>
            <xsl:attribute name="name">export</xsl:attribute>
            <xsl:attribute name="type">hidden</xsl:attribute>
         </input>
         <select><xsl:attribute name="name">export_town_id</xsl:attribute>
           <option><xsl:attribute name="value"></xsl:attribute></option>
           <option><xsl:attribute name="value">3</xsl:attribute>Павлодар</option>
           <option><xsl:attribute name="value">1</xsl:attribute>Семей</option>
           <option><xsl:attribute name="value">2</xsl:attribute>Усть-Каменогорск</option>
         </select>
         <xsl:call-template name="export_form_items"/>
         </form>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="export_result">
    <div><xsl:attribute name="id">export_result</xsl:attribute>
          <xsl:for-each select="/nodes/firms/firm">
              <div><xsl:attribute name="class">firms</xsl:attribute>
                   <div><xsl:attribute name="class">firm_caption</xsl:attribute>
                        <a><xsl:attribute name="title"><xsl:value-of select="./firm_id"/>&#160;<xsl:value-of select="./firm_descr"/></xsl:attribute>
                           <xsl:value-of select="./firm_name"/></a></div>
                           <xsl:for-each select="key('idx_firm_address',./firm_id)">
                                  <xsl:for-each select="key('idx_firm_phone',./address_id)">
                                      <div>
                                          <xsl:value-of select="./phone_description"/> ... <xsl:value-of select="substring(./phone_number,1,2)"/>-<xsl:value-of select="substring(./phone_number,3,2)"/>-<xsl:value-of select="substring(./phone_number,5,2)"/>
                                      </div>
                                  </xsl:for-each>
                           </xsl:for-each>
              </div>
          </xsl:for-each>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="export">
    <div><xsl:attribute name="id">export</xsl:attribute>
         <xsl:attribute name="title">Экспорт</xsl:attribute>
         <xsl:call-template name="export_form"/>
         <xsl:call-template name="export_result"/>
    </div>
</xsl:template>
</xsl:stylesheet>