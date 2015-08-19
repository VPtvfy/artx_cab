<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="utf-8" indent="no" />

  <xsl:key name="idx_block_items" match="/pageroot/catalog/item" use="./pid" />

  <xsl:template match="pageroot">
      <html>
      <head>
      <link href="_css/style.css" rel="stylesheet" type="text/css" />
      </head>
       <body><xsl:attribute name="OnLoad">javascript:window.focus();active.focus();</xsl:attribute>
      <xsl:if test="/pageroot/var/action = 'select' or /pageroot/var/action = 'move'">
       <form method="post" name="blocs" id="blocs_form">
          <xsl:attribute name="target">mainFrame</xsl:attribute>

        <input type="hidden" name="action[none]" id="acion">
             <xsl:attribute name="value">select</xsl:attribute>
        </input>
        <input type="hidden" name="cur_bloc_id" id="src_bloc">
             <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/cur_bloc_id"/></xsl:attribute>
        </input>
        <input type="hidden" name="move_bloc_id" id="move_bloc_id">
           <xsl:if test="/pageroot/var/action = 'move'">
               <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/cur_bloc_id"/></xsl:attribute>
          </xsl:if>
        </input>
      </form>
      </xsl:if>

      <xsl:if test="/pageroot/var/action = 'select'">
       <ul id="blocs">
          <xsl:call-template  name="rootitems">
              <xsl:with-param name="pid"  select="0" />
              <xsl:with-param name="root" select="1" />
              <xsl:with-param name="cur"  select="/pageroot/var/cur_bloc_id" />
              <xsl:with-param name="end"  select="0" />
         </xsl:call-template>
      </ul>
     </xsl:if>
      <xsl:if test="/pageroot/var/action = 'copy'">
       <ul id="blocs">
          <xsl:call-template  name="rootitems">
              <xsl:with-param name="pid"  select="0" />
              <xsl:with-param name="root" select="1" />
              <xsl:with-param name="cur"  select="0" />
              <xsl:with-param name="end"  select="/pageroot/var/cur_bloc_id" />
         </xsl:call-template>
      </ul>
     </xsl:if>
      <xsl:if test="/pageroot/var/action = 'move'">
       <ul id="blocs">
          <xsl:call-template  name="rootitems">
              <xsl:with-param name="pid"  select="0" />
              <xsl:with-param name="root" select="1" />
              <xsl:with-param name="cur"  select="0" />
              <xsl:with-param name="end"  select="/pageroot/var/cur_bloc_id" />
         </xsl:call-template>
      </ul>
     </xsl:if>
      <xsl:if test="/pageroot/var/action = 'none'">
          <xsl:call-template  name="menuitem">
              <xsl:with-param name="id"  select="/pageroot/var/cur_bloc_id" />
              <xsl:with-param name="root" select="1" />
         </xsl:call-template>
     </xsl:if>
      <xsl:if test="/pageroot/var/action = 'refresh'">
        REFRESH
       <form method="post" id="refresh_form" target="blocFrame">
        <input type="hidden" name="cur_bloc_id" id="src_bloc">
             <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/cur_bloc_id"/></xsl:attribute>
        </input>
       </form>
       <script>refresh_form.submit();</script>
     </xsl:if>
      </body>
      </html>
  </xsl:template>

  <xsl:template name="rootitems">
       <xsl:param name='cur'/>
       <xsl:param name='root'/>
       <xsl:param name='end'/>
       <xsl:param name='pid'/>
       <xsl:if test="$root = 1">
           <li>
           <nobr><a><xsl:attribute name="onclick">document.all.src_bloc.value=0;blocs_form.submit();return false</xsl:attribute> 
                    <xsl:if test="$cur=0"><xsl:attribute name="id">active</xsl:attribute></xsl:if>
                    <b>Все рубрики</b><hr />
                </a></nobr>
                 <ul>
                  <xsl:call-template  name="rootitems">
                      <xsl:with-param name="pid"  select="0" />
                      <xsl:with-param name="root" select="0" />
                      <xsl:with-param name="cur"  select="$cur" />
                      <xsl:with-param name="end"  select="$end" />
                 </xsl:call-template>
                </ul>
            </li>
      </xsl:if>
       <xsl:if test="$root != 1">
       <xsl:for-each select="key('idx_block_items',$pid)"><!--xsl:for-each select="/pageroot/catalog/item[pid = $pid]"-->
           <li>
           <xsl:if test="./id !=./pid">
              <nobr><a><xsl:attribute name="title">ID<xsl:value-of select="current()/id"/>&#160;<xsl:value-of select="./data"/>&#160;[<xsl:value-of select="./count"/>&#160;,<xsl:value-of select="./stat"/>&#160;]</xsl:attribute>
                       <xsl:if test="current()/id  = $cur"><xsl:attribute name="id">active</xsl:attribute></xsl:if>
                       <xsl:if test="current()/id  = $end and $end > 0 "><xsl:attribute name="id">active</xsl:attribute></xsl:if>
                       <xsl:if test="current()/id != $end"><xsl:attribute name="class">simple_item</xsl:attribute><xsl:attribute name="href">#</xsl:attribute></xsl:if>
                       <xsl:if test="current()/pid > current()/id"><xsl:attribute name="class">hidden_item</xsl:attribute><xsl:attribute name="href">#</xsl:attribute></xsl:if>
                       <!--xsl:if test="current()/pid > current()/id "><xsl:attribute name="class">parent_item</xsl:attribute><xsl:attribute name="href">#</xsl:attribute></xsl:if-->
                       <xsl:if test="current()/id  = $end"><xsl:attribute name="class">active_item</xsl:attribute><xsl:attribute name="href">#</xsl:attribute></xsl:if>
                       <xsl:attribute name="onclick">document.all.src_bloc.value=<xsl:value-of select="current()/id"/>;blocs_form.submit();return false</xsl:attribute>
                       <xsl:value-of select="./data"/>
                   </a>
                    <a><xsl:if test="./stat > 0">
                       <xsl:if test="current()/stat>0 and current()/count>0"><xsl:attribute name="class">active_item</xsl:attribute></xsl:if>
                       &#160;[<xsl:value-of select="./stat"/>]</xsl:if></a></nobr>

            <xsl:if test="./id != $end">
            <!--xsl:if test="count(following-sibling::.[pid = current()/id])=0"-->
            <xsl:if test="./count>0">
                 <ul>
                  <xsl:call-template  name="rootitems">
                      <xsl:with-param name="pid"  select="current()/id" />
                      <xsl:with-param name="root" select="0" />
                      <xsl:with-param name="cur"  select="$cur" />
                      <xsl:with-param name="end"  select="$end" />
                 </xsl:call-template>
                </ul>
           </xsl:if>
           </xsl:if>
           </xsl:if>
          </li>
      </xsl:for-each>
     </xsl:if>
 </xsl:template>

  <xsl:template name="menuitem">
       <xsl:param name='id'/>
       <xsl:param name='root'/>
       <xsl:for-each select="/pageroot/catalog/item[id = $id]">
            <xsl:if test="./pid > 0">
                <xsl:call-template  name="menuitem">
                    <xsl:with-param name="id"  select="current()/pid" />
                    <xsl:with-param name="root" select="0" />
               </xsl:call-template>&#160;->&#160;
           </xsl:if>
           <xsl:if test="$root != 1 ">&#160;<a class="simple_item"><xsl:value-of select="./data"/></a></xsl:if>
           <xsl:if test="$root  = 1"> <a class="simple_item"><xsl:value-of select="./data"/></a><br />
               <xsl:if test="position() = last()">
                   <form method="post"><br />
                     <input type="hidden" size=" 4" name="cur_bloc_id"><xsl:attribute name="value"><xsl:value-of select="./id"/></xsl:attribute></input>
                     <input type="hidden" size=" 4" name="cur_bloc_pid"><xsl:attribute name="value"><xsl:value-of select="./pid"/></xsl:attribute></input>
                     <input type="text" size="64" maxlength = "64" name="name_str">
                     <xsl:if test="./id != 0"><xsl:attribute name="value"><xsl:value-of select="./data"/></xsl:attribute></xsl:if>
                     </input><br />
                         <input type="submit" name="action[add]"><xsl:attribute name="value">Создать</xsl:attribute></input>
                         <xsl:if test="./id != 0">
                             <input type="submit" name="action[edit]"><xsl:attribute name="value">Изменить</xsl:attribute></input>
                             <xsl:if test="./count = 0">
                                 <input type="submit" name="action[join]"><xsl:attribute name="value">Удалить</xsl:attribute></input>
                            </xsl:if>
                        </xsl:if>
                   </form>
                    <form method="post" target="blocFrame"> 
                     <input type="submit" name="action[move]"><xsl:attribute name="value">Переместить</xsl:attribute></input>
                     <br/><br/>Фирмы рубрики<br />
                     <input type="submit" name="action[move]"><xsl:attribute name="value">Переместить</xsl:attribute></input>
                     <input type="hidden" size=" 4" name="cur_bloc_id"><xsl:attribute name="value"><xsl:value-of select="./id"/></xsl:attribute></input>
                     <input type="hidden" size=" 4" name="cur_bloc_pid"><xsl:attribute name="value"><xsl:value-of select="./pid"/></xsl:attribute></input>
                    </form>
              </xsl:if>
          </xsl:if>
      </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
