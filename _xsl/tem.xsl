<div><xsl:attribute name="id">quick_search</xsl:attribute>
  <div><xsl:attribute name="id">location_div</xsl:attribute>
    <ul>
       <li>
         <input><xsl:attribute name="id">0</xsl:attribute> 
                <xsl:attribute name="name">city</xsl:attribute> 
                <xsl:attribute name="type">radio</xsl:attribute> 
         </input>
         <label for="allcity"><span>Искать во всех городах</span></label>
       </li>
         <li>
          <input><xsl:attribute name="id">city1</xsl:attribute> 
                <xsl:attribute name="name">city</xsl:attribute> 
                <xsl:attribute name="type">radio</xsl:attribute>  id="city0" name="city" value="1" type="radio"></input>
          <label for="city0"><span>Искать в г. Павлодар</span></label>
       </li>
       <li>
         <input><xsl:attribute name="id">city1</xsl:attribute> 
                <xsl:attribute name="name">city</xsl:attribute> 
                <xsl:attribute name="type">radio</xsl:attribute>  id="city1" name="city" type="radio"></input>
         <label for="city1"><span>Искать в г. Семей</span></label>
       </li>
       <li>
         <input><xsl:attribute name="id">city2</xsl:attribute> 
                <xsl:attribute name="name">city</xsl:attribute> 
                <xsl:attribute name="type">radio</xsl:attribute>  id="city2" name="city" value="Усть-Каменогорск" type="radio"></input>
         <label for="city2"><span>Искать в г. Усть-Каменогорск</span></label>
       </li>
    </ul>
  </div>
  <form name="qsearch" id="qsearch" method="post">
    <div id="search_for">ЧТО БУДЕМ ИСКАТЬ:</div>
    <input id="qs_keyword" autocomplete="off" name="qs_keyword" value="" placeholder="Артекс или 209098" size="35" type="text"></input>
    <input name="order" value="date_added" type="hidden"></input>
    <input name="order_way" value="desc" type="hidden"></input>
    <input name="Search" id="Search" value="" type="submit"></input>
  </form>
<div id="bg-search2"></div>
		