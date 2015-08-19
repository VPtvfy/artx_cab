<?xml version="1.0" encoding="utf-8"?><!-- DWXMLSource="../catalog.xml" -->
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY mdash  "&#8212;">
	<!ENTITY ldquo  "&#8220;">
	<!ENTITY rdquo  "&#8221;"> 
	<!ENTITY pound  "&#163;">
	<!ENTITY yen    "&#165;">
	<!ENTITY euro   "&#8364;">]>
  <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="town.xsl" />
  <xsl:import href="cmenu.xsl" />
  <xsl:import href="rsubdiv.xsl" />
  <xsl:output method="html" encoding="utf-8" indent="no" />
  <xsl:template match="pageroot">
      <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
      <title>Желтые страницы прииртышья</title>
      <link href="_css/style.css" rel="stylesheet" type="text/css" />
      </head>
      <body><br/>
     <form action="" method="post" name="find" id="find">
           <xsl:call-template name="town">
               <xsl:with-param name="show_all"  select="1" />
               <xsl:with-param name="town_id"   select="/pageroot/var/town_id" />
          </xsl:call-template>
           <xsl:call-template name="menuitems">
               <xsl:with-param name="pid"  select="/pageroot/var/class_id" />
               <xsl:with-param name="show_all"  select="1" />
               <xsl:with-param name="pname" select="1"/>
          </xsl:call-template>
          <input type='submit'></input></form>
          <h1><xsl:value-of select ="/pageroot/catalog/item[id = /pageroot/var/class_id]/data"/><br/></h1><br/>
          <xsl:call-template name="firm"/>
      </body>
      </html>
  </xsl:template>
</xsl:stylesheet>
