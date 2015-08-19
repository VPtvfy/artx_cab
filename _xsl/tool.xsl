<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

<xsl:output method="html" encoding="utf-8" indent="no"/>

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
              <xsl:attribute name="target">#login_status</xsl:attribute>
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
              <div>
                  <xsl:attribute name="id">login_status</xsl:attribute>
              </div>
        </form>
      </div>
</xsl:template>
<!--
-->
<xsl:template name="login_status">
    <xsl:if test="/state/login_status='success'">
      <div>Login successful</div>
    </xsl:if>
    <xsl:if test="/state/login_status!='success'">
      <div>Login failed</div>
    </xsl:if>
</xsl:template>
<!--
-->
<xsl:template name="new_firm_form">
    <div><xsl:attribute name="id">new_firm_form</xsl:attribute>
         <xsl:attribute name="title">Создать фирму</xsl:attribute>
         <div><xsl:attribute name="id">new_firm</xsl:attribute>
            <form><xsl:attribute name="method">get</xsl:attribute>
                  <xsl:attribute name="target">#new_firm_details</xsl:attribute>
                  <input><xsl:attribute name="name">new_firm</xsl:attribute>
                         <xsl:attribute name="type">hidden</xsl:attribute></input>
                  <input>
                      <xsl:attribute name="id">new_firm_name</xsl:attribute> 
                      <xsl:attribute name="name">new_firm_name</xsl:attribute> 
                      <xsl:attribute name="type">text</xsl:attribute>
                      <xsl:attribute name="placeholder">Создать фирму</xsl:attribute>
                  </input>
                  <input>
                      <xsl:attribute name="id">new_firm_btn</xsl:attribute> 
                      <xsl:attribute name="type">submit</xsl:attribute>
                      <xsl:attribute name="value">Создать</xsl:attribute>
                  </input>
            </form>
         </div>
         <div><xsl:attribute name="id">new_firm_details</xsl:attribute></div>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="new_firm_item">
</xsl:template>
<xsl:template name="new_firm_items">
    <div>
         <div><xsl:attribute name="id">new_firm_items</xsl:attribute>
            <xsl:for-each select='/nodes/firm/item'>
                 <div><a>
                         <xsl:value-of select="item_name"/></a></div>
            </xsl:for-each></div>
         <div>
            <form><xsl:attribute name="method">get</xsl:attribute>
                  <xsl:attribute name="target">#new_firm_items</xsl:attribute>
                  <input><xsl:attribute name="name">new_firm_item</xsl:attribute>
                         <xsl:attribute name="type">hidden</xsl:attribute>
                  </input>
                  <input><xsl:attribute name="name">new_firm_id</xsl:attribute>
                         <xsl:attribute name="type">hidden</xsl:attribute>
                         <xsl:attribute name="value"><xsl:value-of select="/state/firm_id"/></xsl:attribute>
                  </input>

                  <input>
                      <xsl:attribute name="id">new_firm_item_name</xsl:attribute> 
                      <xsl:attribute name="name">new_firm_item_name</xsl:attribute> 
                      <xsl:attribute name="type">text</xsl:attribute>
                      <xsl:attribute name="placeholder">Рубрика</xsl:attribute>
                  </input>
                  <input>
                      <xsl:attribute name="id">new_firm_item_descr</xsl:attribute> 
                      <xsl:attribute name="name">new_firm_item_descr</xsl:attribute> 
                      <xsl:attribute name="type">text</xsl:attribute>
                      <xsl:attribute name="placeholder">Дополнение</xsl:attribute>
                  </input>

                  <input>
                     <xsl:attribute name="type">submit</xsl:attribute>
                     <xsl:attribute name="value">+</xsl:attribute>
                     <xsl:attribute name="class">ui-widget</xsl:attribute>
                  </input>

            </form>
         </div>
    </div>
</xsl:template>

<xsl:template name="new_firm_details">
     <div><xsl:attribute name="id">new_firm_details</xsl:attribute>
          <xsl:call-template name="new_firm_items"/>
          <!--xsl:call-template name="new_firm_addreses"/-->
          <!--xsl:call-template name="new_firm_phones"/-->
     </div>
</xsl:template>

</xsl:stylesheet>