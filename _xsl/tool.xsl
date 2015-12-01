<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="logo_tools">
    <ul>
      <li><xsl:attribute name="id">logo_tools_login</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
      <li><xsl:attribute name="id">logo_tools_firm</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
      <li><xsl:attribute name="id">logo_tools_catalog</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
      <li><xsl:attribute name="id">logo_tools_street</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
      <li><xsl:attribute name="id">logo_tools_export</xsl:attribute>
       <a><xsl:attribute name="href">#</xsl:attribute>*</a></li>
    </ul>
</xsl:template>
<!--
-->
<xsl:template name="tool_forms">
    <div><xsl:attribute name="id">tool_forms</xsl:attribute>
         <xsl:call-template name="login_form"/>
         <xsl:call-template name="edit_firm"/>
         <xsl:call-template name="export"/>
    </div>
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
               <div><xsl:attribute name="class">ui-dialog-buttonset</xsl:attribute>
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
</xsl:stylesheet>