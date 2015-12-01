<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="edit_firm_phones">
    <xsl:param name="address_id"/>
        <xsl:for-each select="key('idx_firm_phone',$address_id)">
            <div><xsl:attribute name="id">firm_phone_id=<xsl:value-of select="./phone_id"/></xsl:attribute>
                 <xsl:attribute name="class">firm_phone</xsl:attribute>
                 <xsl:if test='./phone_code!=""'>(<xsl:value-of select="./phone_code"/>)</xsl:if>
                 <a><xsl:attribute name="href">phone=<xsl:value-of select="./phone_id"/></xsl:attribute>
                    <xsl:attribute name="title"><xsl:value-of select="./phone_description"/></xsl:attribute>
                    <xsl:value-of select="./phone_number"/></a>
            </div>
        </xsl:for-each>
</xsl:template>
<!--
-->
<xsl:template name="edit_firm_address">
    <xsl:param name="firm_id"/>
    <div><xsl:attribute name="class">address</xsl:attribute>
         <xsl:for-each select="key('idx_firm_address',$firm_id)">
             <form>
                 <fieldset>
                    <legend>
                          <a><xsl:attribute name="href">firm_address=<xsl:value-of select="./address_id"/></xsl:attribute>
                          г.<xsl:value-of select="./town_name"/>
                          &#160;<xsl:value-of select="./street_name"/>
                          &#160;<xsl:value-of select="./building"/>
                          &#160;<xsl:value-of select="./office"/>
                          </a>
                    </legend>
                      <xsl:call-template name="edit_firm_phones">
                          <xsl:with-param name="address_id" select="./address_id"/>
                      </xsl:call-template>
                 </fieldset>
             </form>
         </xsl:for-each>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="firm_address_form">
    <div><xsl:attribute name="id">edit_firm_address</xsl:attribute>
         <xsl:if test='/state/firm_id !=0'>
             <xsl:call-template name="edit_firm_address">
                 <xsl:with-param name="firm_id" select="/state/firm_id"/>
             </xsl:call-template>
                 <fieldset>
                    <legend>
             <form>
               <input>
                 <xsl:attribute name="name">firm_id</xsl:attribute>
                 <xsl:attribute name="type">hidden</xsl:attribute>
                 <xsl:attribute name="value"><xsl:value-of select ="/state/firm_id"/></xsl:attribute>
               </input>
               <select><xsl:attribute name="name">firm_town_id</xsl:attribute>
                 <option><xsl:attribute name="value">3</xsl:attribute>Павлодар</option>
                 <option><xsl:attribute name="value">1</xsl:attribute>Семей</option>
                 <option><xsl:attribute name="value">2</xsl:attribute>Усть-Каменогорск</option>
               </select>
               <input>
                 <xsl:attribute name="name">firm_street_name</xsl:attribute>
                 <xsl:attribute name="type">text</xsl:attribute>
                 <xsl:attribute name="placeholder">улица</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">firm_building</xsl:attribute>
                 <xsl:attribute name="type">text</xsl:attribute>
                 <xsl:attribute name="size">5</xsl:attribute>
                 <xsl:attribute name="placeholder">дом</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">firm_office</xsl:attribute>
                 <xsl:attribute name="type">text</xsl:attribute>
                 <xsl:attribute name="size">5</xsl:attribute>
                 <xsl:attribute name="placeholder">оффис</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">add_firm_address</xsl:attribute>
                 <xsl:attribute name="type">submit</xsl:attribute>
                 <xsl:attribute name="value">+</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">del_firm_address</xsl:attribute>
                 <xsl:attribute name="type">submit</xsl:attribute>
                 <xsl:attribute name="value">-</xsl:attribute>
               </input>
             </form>
                  </legend>
                 </fieldset>

         </xsl:if>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="edit_firm_item">
    <xsl:param name="firm_id"/>
    <xsl:param name="item_id"/>
    <xsl:param name="item_name"/>
        <div><xsl:attribute name="class">firm_item</xsl:attribute>            
             <input>
                <xsl:attribute name="type">hidden</xsl:attribute>
                <xsl:if test="$item_id=0"><xsl:attribute name="name">firm_add_item</xsl:attribute></xsl:if>
                <xsl:if test="$item_id>0"><xsl:attribute name="name">firm_edit_item</xsl:attribute></xsl:if>
                <xsl:attribute name="value"><xsl:value-of select="./item_id"/></xsl:attribute>
             </input>
             <input>
                <xsl:attribute name="id">edit_firm_item_name</xsl:attribute>
                <xsl:attribute name="name">item_name</xsl:attribute>
                <xsl:attribute name="type">text</xsl:attribute>
                <xsl:if test="./item_name!=''"><xsl:attribute name="value"><xsl:value-of select="./item_name"/></xsl:attribute></xsl:if>
                <xsl:if test="./item_name =''"><xsl:attribute name="placeholder">Рубрика : Описание</xsl:attribute></xsl:if>
             </input>
             <!--input>
                <xsl:attribute name="name">firm_item_add</xsl:attribute>
                <xsl:attribute name="type">submit</xsl:attribute>
                <xsl:attribute name="value">+</xsl:attribute>
             </input>
             <input>
                <xsl:attribute name="name">firm_item_del</xsl:attribute>
                <xsl:attribute name="type">submit</xsl:attribute>
                <xsl:attribute name="value">-</xsl:attribute>
             </input-->
        </div> 
</xsl:template>
<!--
-->
<xsl:template name="edit_firm_items">
    <xsl:param name="firm_id"/>
    <div><xsl:attribute name="class">firm_items</xsl:attribute>
        <form>
           <input>
              <xsl:attribute name="type">hidden</xsl:attribute>
              <xsl:attribute name="name">firm_id</xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select ="/state/firm_id"/></xsl:attribute>
           </input>
           <xsl:for-each select="key('idx_firm_item',$firm_id)">
               <xsl:choose>
                   <xsl:when test="./item_id=/state/item_id">
                       <xsl:call-template  name='edit_firm_item'>
                           <xsl:with-param name='firm_id'   select='./firm_id'/>
                           <xsl:with-param name='item_id'   select='./item_id'/>
                           <xsl:with-param name='item_name' select='./item_name'/>
                       </xsl:call-template>
                   </xsl:when>
                   <xsl:otherwise>
                       <div><xsl:attribute name="class">firm_item</xsl:attribute>            
                            <a><xsl:attribute name="href">item_id=<xsl:value-of select="./item_id"/></xsl:attribute>
                               <xsl:value-of select="./item_name"/></a>
                       </div>
                   </xsl:otherwise>
               </xsl:choose>
           </xsl:for-each>
           <div><xsl:attribute name="class">firm_item</xsl:attribute>            
                <a><xsl:attribute name="href">item_id=0</xsl:attribute>
                   Новая рубика</a>
           </div>
        </form>
     </div>
</xsl:template>
<!--
-->
<xsl:template name="firm_items_form">
    <div><xsl:attribute name="id">edit_firm_items</xsl:attribute>
         <xsl:if test='/state/firm_id !=0'>
             <div>
                 <fieldset>
                    <legend> Рубрики </legend>
                    <xsl:call-template name="edit_firm_items">
                        <xsl:with-param name="firm_id" select="/state/firm_id"/>
                    </xsl:call-template>
                 </fieldset>
             </div>
         </xsl:if>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="firm_name_form">
    <div><xsl:attribute name="id">edit_firm_form</xsl:attribute>
        <form>
            <input>
               <xsl:attribute name="name">firm</xsl:attribute>
               <xsl:attribute name="type">hidden</xsl:attribute>
            </input>
            <input>
               <xsl:attribute name="name">firm_id</xsl:attribute>
               <xsl:attribute name="type">hidden</xsl:attribute>
               <xsl:attribute name="value"><xsl:value-of select ="/state/firm_id"/></xsl:attribute>
            </input>
            <input>
               <xsl:attribute name="id">edit_firm_name</xsl:attribute>
               <xsl:attribute name="name">firm_name</xsl:attribute>
               <xsl:attribute name="type">text</xsl:attribute>
               <xsl:attribute name="placeholder">Создать фирму</xsl:attribute>
               <xsl:if test='/state/firm_id !=0'>
                   <xsl:attribute name="value"><xsl:value-of select ="/state/firm_name"/></xsl:attribute></xsl:if>
            </input>
            <input>
               <xsl:attribute name="id">edit_firm_btn</xsl:attribute>
               <xsl:attribute name="type">submit</xsl:attribute>
               <xsl:choose>
                   <xsl:when test="/state/firm_id!=''">
                       <xsl:attribute name="name">create_firm</xsl:attribute>
                       <xsl:attribute name="value">Создать</xsl:attribute>
                   </xsl:when>
                   <xsl:otherwise>
                       <xsl:attribute name="name">find_firm</xsl:attribute>
                       <xsl:attribute name="value">Поиск</xsl:attribute>
                   </xsl:otherwise>
               </xsl:choose>
            </input>
        </form>
     </div>
</xsl:template>
<!--
-->
<xsl:template name="edit_firm">
    <div><xsl:attribute name="id">edit_firm</xsl:attribute>
         <xsl:attribute name="title">Создать/Редактровать фирму</xsl:attribute>
         <xsl:call-template name="firm_name_form"/>
         <xsl:call-template name="firm_items_form"/>
         <xsl:call-template name="firm_address_form"/>
    </div>
</xsl:template>
</xsl:stylesheet>