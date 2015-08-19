<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
     xmlns="http://www.w3.org/1999/xhtml"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

<xsl:import href="item.xsl"/>
<xsl:import href="find.xsl"/>
<xsl:import href="firm.xsl"/>
<xsl:import href="tool.xsl"/>

<xsl:output method="html" encoding="utf-8" indent="no"/>

<xsl:template name="top_banner">
 <div><xsl:attribute name="id">topbanner</xsl:attribute>
 </div><img border="0" src="_img/s620.gif"/>
</xsl:template>
<!--
-->
<xsl:template name="logo_menu">
    <ul>
      <li><a href="content.php?id=2">Компания</a></li>
      <li><a href="content.php?id=3">Регион</a></li>
      <li><a href="content.php?id=5">Рекламодателю</a></li>
      <li><a href="content.php?id=4">Полезное</a></li>
      <li><a href="/contact.php" class="hidden_when_small">Контакты</a></li>
    </ul>
</xsl:template>
<!--
-->
<xsl:template name="logo">
    <div><xsl:attribute name="id">logo_menu</xsl:attribute>
        <xsl:call-template name="logo_menu"/></div>
    <div><xsl:attribute name="id">logo_tools</xsl:attribute>
        <xsl:call-template name="logo_tools"/></div>
</xsl:template>
<!--
-->
<xsl:template name="header">
    <div><xsl:attribute name="class">inner</xsl:attribute>
         <div><xsl:attribute name="id">logo</xsl:attribute>
             <xsl:call-template name="logo"/></div>
         <div><xsl:attribute name="id">find_form</xsl:attribute>
             <xsl:call-template name="find_form"/></div>
         <div><xsl:attribute name="id">alphaindex</xsl:attribute>
              <xsl:call-template name="alphaindex"/></div>
    </div>
</xsl:template>
<!--
-->
<xsl:template name="result">
    <div><xsl:attribute name="id">result_cat</xsl:attribute>
         <xsl:call-template name="items"><xsl:with-param name="item_id" select="/state/item" /></xsl:call-template></div>
    <div><xsl:attribute name="id">result_firm</xsl:attribute>result_firm
         <!--xsl:call-template name="result_firm"/--></div>
</xsl:template>
<!--
-->
<xsl:template name="footer">
    <div><xsl:attribute name="class">inner</xsl:attribute>
        <div><img><xsl:attribute name="src">_img/copyright.png</xsl:attribute>
                  <xsl:attribute name="alt">Все права защищены © Телефонный справочник "Прииртышье".
                  Все логотипы и торговые марки на сайте являются собственностью их владельцев.</xsl:attribute></img>
                  Все права защищены © Телефонный справочник "Прииртышье". 
                  Все логотипы и торговые марки на сайте являются собственностью их владельцев.</div></div>
    <div><xsl:call-template name="login_form"/></div>
    <div><xsl:call-template name="new_firm_form"/></div>
</xsl:template>

<!--Main template
-->
<xsl:template name="index">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <meta>
       <xsl:attribute name="name">description</xsl:attribute>
       <xsl:attribute name="content">Спровочник Приитышье</xsl:attribute>
      </meta>
      <meta>
       <xsl:attribute name="name">description</xsl:attribute>
       <xsl:attribute name="content">Спровочник Приитышье</xsl:attribute>
      </meta>
      <meta>
       <xsl:attribute name="name">keywords</xsl:attribute>
       <xsl:attribute name="content">Спровочник Приитышье</xsl:attribute>
      </meta>
      <meta>
       <xsl:attribute name="robots">keywords</xsl:attribute>
       <xsl:attribute name="content">all</xsl:attribute>
      </meta>
      <link rel="stylesheet" href="_js/jquery/jquery-ui/jquery-ui.css"/>
      <script src="_js/jquery/jquery.js"></script>
      <script src="_js/jquery/jquery-ui/jquery-ui.js"></script>
  
      <link rel="stylesheet" type="text/css" media="all" href="_css/style.css"/>
      <script src="_js/index.js"></script>
    </head>
    <body>
      <div><xsl:attribute name="id">top</xsl:attribute>
           <xsl:call-template name="top_banner"/></div>
      <div><xsl:attribute name="id">page_wrapper</xsl:attribute>
           <div><xsl:attribute name="id">page_header</xsl:attribute>
                <xsl:attribute name="class">clearfix</xsl:attribute>
                <xsl:call-template name="header"/></div>
           <div><xsl:attribute name="id">result</xsl:attribute>
                <xsl:call-template name="result"/></div>
       </div>
       <div><xsl:attribute name="id">footer</xsl:attribute>
            <xsl:call-template name="footer"/></div>
    </body>
    </html>
</xsl:template>

<xsl:template name ="status">
    <ul>
    <xsl:for-each select="/status">
      <li>var<xsl:value-of select="name()"/></li>
    </xsl:for-each>
    </ul>
</xsl:template>

<xsl:template match="/">
    <xsl:if test="/state/event='index'">
        <xsl:call-template name='index'/>
    </xsl:if>
    <xsl:if test="/state/event='alpha'">
        <xsl:call-template name="items"><xsl:with-param name="item_id" select="0"/></xsl:call-template>
    </xsl:if>
    <xsl:if test="/state/event='item'">
        <xsl:call-template name="items"><xsl:with-param name="item_id" select="/state/item"/></xsl:call-template>
    </xsl:if>
    <xsl:if test="/state/event='find'">
        <xsl:call-template name='firms'/>
    </xsl:if>
    <xsl:if test="/state/event='login'">
        <xsl:call-template name='login_status'/>
    </xsl:if>

    <xsl:if test="/state/event='new_firm'">
        <xsl:call-template name='new_firm_details'/>
    </xsl:if>
    <xsl:if test="/state/event='new_firm_item'">
        <xsl:call-template name='new_firm_items'/>
    </xsl:if>
    <xsl:if test="/state/event='new_firm_address'">
        <xsl:call-template name='new_firm_addreses'/>
    </xsl:if>
    <xsl:if test="/state/event='new_firm_phone'">
        <xsl:call-template name='new_firm_phoness'/>
    </xsl:if>
</xsl:template>
</xsl:stylesheet>