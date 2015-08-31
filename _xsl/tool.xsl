<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="tool_forms">
    <div><xsl:attribute name="id">tool_forms</xsl:attribute>
      <div><xsl:call-template name="login_form"/></div>
      <div><xsl:call-template name="new_firm"/></div>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="logo_tools">
    <ul>
      <li><xsl:attribute name="id">logo_tools_login</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
      <li><xsl:attribute name="id">logo_tools_catalog</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
      <li><xsl:attribute name="id">logo_tools_street</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
      <li><xsl:attribute name="id">logo_tools_firm</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
    </ul>
</xsl:template>
<!--
-->
<xsl:template name="login_form">
    <div><xsl:attribute name="id">login_form</xsl:attribute>
         <xsl:attribute name="title">Login user</xsl:attribute>
        <form><xsl:attribute name="name">login</xsl:attribute>
              <xsl:attribute name="method">post</xsl:attribute>
               <label for="login">Login</label>
               <input>
                  <xsl:attribute name="id">login</xsl:attribute>
                  <xsl:attribute name="name">login</xsl:attribute>
                  <xsl:attribute name="type">text</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/state/user_id"/></xsl:attribute>
                  <xsl:attribute name="class">text</xsl:attribute>
                  <xsl:attribute name="class">ui-widget-content</xsl:attribute>
                  <xsl:attribute name="class">ui-corner-all</xsl:attribute>
               </input>
               <label for="password">Password</label>
               <input>
                  <xsl:attribute name="id">passwd</xsl:attribute>
                  <xsl:attribute name="name">passwd</xsl:attribute>
                  <xsl:attribute name="type">password</xsl:attribute>
                  <xsl:attribute name="class">text</xsl:attribute>
                  <xsl:attribute name="class">ui-widget-content</xsl:attribute>
                  <xsl:attribute name="class">ui-corner-all</xsl:attribute>
               </input>
               <div>
                  <xsl:attribute name="class">ui-dialog-buttonset</xsl:attribute>
                <input>
                  <xsl:attribute name="type">submit</xsl:attribute>
                  <xsl:attribute name="value">Login</xsl:attribute>
                  <xsl:attribute name="class">ui-widget</xsl:attribute>
                  <xsl:attribute name="class">ui-state-default</xsl:attribute>
                  <xsl:attribute name="class">ui-corner-all</xsl:attribute>
                  <xsl:attribute name="class">ui-button-text-only</xsl:attribute>
                </input>
              </div>
              <xsl:call-template name='login_status'/>
        </form>
      </div>
</xsl:template>
<!--
-->
<xsl:template name="login_status">
    <div><xsl:attribute name="id">login_status</xsl:attribute>
    <xsl:if test="/state/login_status='success'">
      Login successful
    </xsl:if>
    <xsl:if test="/state/login_status!='success'">
      Login failed
    </xsl:if>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="new_firm_phone">
    <div><xsl:attribute name="id">new_firm_phone</xsl:attribute>
         <xsl:if test='/state/new_firm_id !=0'>
              <fieldset><legend>Телефоны</legend>
                <xsl:call-template name="firm_phones">
                    <xsl:with-param name="firm_id" select="/state/new_firm_id"/>
                </xsl:call-template>
              </fieldset>
         </xsl:if>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="new_firm_address">
    <div><xsl:attribute name="id">new_firm_address</xsl:attribute>
         <xsl:if test='/state/new_firm_id !=0'>
             <fieldset>
               <legend> Адрес <xsl:value-of select="/state/new_firm_id"/></legend>
               <xsl:call-template name="firm_address">
                   <xsl:with-param name="firm_id" select="/state/new_firm_id"/>
               </xsl:call-template>
             </fieldset>
             <form>
               <input>
                 <xsl:attribute name="name">new_firm_street</xsl:attribute>
                 <xsl:attribute name="type">hidden</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">new_firm_id</xsl:attribute>
                 <xsl:attribute name="type">hidden</xsl:attribute>
                 <xsl:attribute name="value"><xsl:value-of select ="/state/new_firm_id"/></xsl:attribute>
               </input>
               <select><xsl:attribute name="name">new_firm_town_id</xsl:attribute>
                 <option><xsl:attribute name="value">3</xsl:attribute>Павлодар</option>
                 <option><xsl:attribute name="value">1</xsl:attribute>Семей</option>
                 <option><xsl:attribute name="value">2</xsl:attribute>Усть-Каменогорск</option>
               </select>
               <input>
                 <xsl:attribute name="name">new_firm_street_name</xsl:attribute>
                 <xsl:attribute name="type">text</xsl:attribute>
                 <xsl:attribute name="placeholder">улица</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">new_firm_building</xsl:attribute>
                 <xsl:attribute name="type">text</xsl:attribute>
                 <xsl:attribute name="size">5</xsl:attribute>
                 <xsl:attribute name="placeholder">дом</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">new_firm_office</xsl:attribute>
                 <xsl:attribute name="type">text</xsl:attribute>
                 <xsl:attribute name="size">5</xsl:attribute>
                 <xsl:attribute name="placeholder">оффис</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">new_firm_address_add</xsl:attribute>
                 <xsl:attribute name="type">submit</xsl:attribute>
                 <xsl:attribute name="value">+</xsl:attribute>
               </input>
               <input>
                 <xsl:attribute name="name">new_firm_address_del</xsl:attribute>
                 <xsl:attribute name="type">submit</xsl:attribute>
                 <xsl:attribute name="value">-</xsl:attribute>
               </input>
             </form>
         </xsl:if>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="new_firm_item">
    <div><xsl:attribute name="id">new_firm_items</xsl:attribute>
         <xsl:if test='/state/new_firm_id !=0'>
              <div>
                 <fieldset>
                   <legend> Рубрики </legend>
                   <xsl:call-template name="firm_items">
                       <xsl:with-param name="firm_id" select="/state/new_firm_id"/>
                   </xsl:call-template>
                 </fieldset>
              </div>
              <div>
                 <form>
                   <input>
                      <xsl:attribute name="name">new_firm_item</xsl:attribute>
                      <xsl:attribute name="type">hidden</xsl:attribute>
                   </input>
                   <input>
                      <xsl:attribute name="name">new_firm_id</xsl:attribute>
                      <xsl:attribute name="type">hidden</xsl:attribute>
                      <xsl:attribute name="value"><xsl:value-of select ="/state/new_firm_id"/></xsl:attribute>
                   </input>
                   <input>
                      <xsl:attribute name="id">new_firm_item_name</xsl:attribute>
                      <xsl:attribute name="name">new_firm_item_name</xsl:attribute>
                      <xsl:attribute name="type">text</xsl:attribute>
                      <xsl:attribute name="placeholder">Рубрика : Описание</xsl:attribute>
                   </input>
                   <input>
                      <xsl:attribute name="name">new_firm_item_add</xsl:attribute>
                      <xsl:attribute name="type">submit</xsl:attribute>
                      <xsl:attribute name="value">+</xsl:attribute>
                   </input>
                   <input>
                      <xsl:attribute name="name">new_firm_item_del</xsl:attribute>
                      <xsl:attribute name="type">submit</xsl:attribute>
                      <xsl:attribute name="value">-</xsl:attribute>
                   </input>
                 </form>
              </div>
         </xsl:if>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="new_firm_form">
    <div><xsl:attribute name="id">new_firm_form</xsl:attribute>
       <form>
         <input>
            <xsl:attribute name="name">new_firm</xsl:attribute>
            <xsl:attribute name="type">hidden</xsl:attribute>
         </input>
         <input>
            <xsl:attribute name="name">new_firm_id</xsl:attribute>
            <xsl:attribute name="type">hidden</xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select ="/state/new_firm_id"/></xsl:attribute>
         </input>
         <input>
            <xsl:attribute name="id">new_firm_name</xsl:attribute>
            <xsl:attribute name="name">new_firm_name</xsl:attribute>
            <xsl:attribute name="type">text</xsl:attribute>
            <xsl:attribute name="placeholder">Создать фирму</xsl:attribute>
            <xsl:if test='/state/new_firm_id !=0'>
                <xsl:attribute name="value"><xsl:value-of select ="/state/new_firm_name"/></xsl:attribute></xsl:if>
         </input>
         <input>
           <xsl:attribute name="id">new_firm_btn</xsl:attribute>
           <xsl:attribute name="type">submit</xsl:attribute>
           <xsl:if test='/state/new_firm_id =""'>
               <xsl:attribute name="value">Создать</xsl:attribute></xsl:if>
           <xsl:if test='/state/new_firm_id >0'>
               <xsl:attribute name="value">Переименовать</xsl:attribute></xsl:if>
         </input>
       </form>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="new_firm">
    <div><xsl:attribute name="id">new_firm</xsl:attribute>
         <xsl:attribute name="title">Создать/Редактровать фирму</xsl:attribute>
         <xsl:call-template name="new_firm_form"/>
         <xsl:call-template name="new_firm_item"/>
         <xsl:call-template name="new_firm_address"/>
         <xsl:call-template name="new_firm_phone"/>
    </div>
</xsl:template>
</xsl:stylesheet>