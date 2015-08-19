<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

  <xsl:template name="find_form">
        <div><xsl:attribute name="id">quick_search</xsl:attribute>
          <form>
          <xsl:attribute name="id">qsearch</xsl:attribute>
          <xsl:attribute name="name">qsearch</xsl:attribute>
          <xsl:attribute name="method">post</xsl:attribute>
          <xsl:attribute name="target">#result_firm</xsl:attribute>
          <input><xsl:attribute name="name">find</xsl:attribute>
                 <xsl:attribute name="type">hidden</xsl:attribute></input>
          <div><xsl:attribute name="id">location_div</xsl:attribute>
            <ul>
               <li>
                 <input><xsl:attribute name="id">twnall</xsl:attribute> 
                        <xsl:attribute name="name">town</xsl:attribute> 
                        <xsl:attribute name="value">0</xsl:attribute> 
                        <xsl:attribute name="type">radio</xsl:attribute>
                        <xsl:if test="/state/town=0">
                             <xsl:attribute name="checked"/>
                        </xsl:if> 
                 </input>
                 <label for="twnall"><span>Искать во всех городах</span></label>
               </li>
               <li>
                 <input><xsl:attribute name="id">twnpvl</xsl:attribute> 
                        <xsl:attribute name="name">town</xsl:attribute> 
                        <xsl:attribute name="value">2</xsl:attribute> 
                        <xsl:attribute name="type">radio</xsl:attribute>
                        <xsl:if test="/state/town=2">
                             <xsl:attribute name="checked"/>
                        </xsl:if>
                 </input>
                 <label for="twnpvl"><span>Искать в г. Павлодар</span></label>
               </li>
               <li>
                 <input><xsl:attribute name="id">twnspl</xsl:attribute> 
                        <xsl:attribute name="name">town</xsl:attribute> 
                        <xsl:attribute name="value">1</xsl:attribute> 
                        <xsl:attribute name="type">radio</xsl:attribute>
                        <xsl:if test="/state/town=1">
                             <xsl:attribute name="checked"/>
                        </xsl:if>
                 </input>
                 <label for="twnspl"><span>Искать в г. Семей</span></label>
               </li>
               <li>
                 <input><xsl:attribute name="id">twnukg</xsl:attribute> 
                        <xsl:attribute name="name">town</xsl:attribute> 
                        <xsl:attribute name="value">3</xsl:attribute> 
                        <xsl:attribute name="type">radio</xsl:attribute>
                        <xsl:if test="/state/town=3">
                             <xsl:attribute name="checked"/>
                        </xsl:if>
                  </input>
                 <label for="twnukg"><span>Искать в г. Усть-Каменогорск</span></label>
               </li>
            </ul>
          </div>
          <div><xsl:attribute name="id">search_for</xsl:attribute>ПОИСК:</div>
          <input>
             <xsl:attribute name="id">quick_search_keyword</xsl:attribute> 
             <xsl:attribute name="name">keyword</xsl:attribute> 
             <xsl:attribute name="type">text</xsl:attribute>
             <xsl:attribute name="size">35</xsl:attribute>
             <xsl:attribute name="value"><xsl:value-of select="/state/keyword"/></xsl:attribute>
             <xsl:attribute name="autocomplete">off</xsl:attribute>
          </input>
          <input>
             <xsl:attribute name="name">search</xsl:attribute> 
             <xsl:attribute name="type">submit</xsl:attribute>
             <xsl:attribute name="value"></xsl:attribute>
          </input>
          </form>
          <div id="bg-search2"></div>
        </div>
  </xsl:template>
</xsl:stylesheet>
