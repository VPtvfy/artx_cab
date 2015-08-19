<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="town.xsl" />
<xsl:import href="cmenu.xsl" />
<xsl:output method="html" encoding="windows-1251" indent="no" />
<xsl:template match="pageroot">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<form method="post">
<table border="0">
  <tr>
    <td>
      <table border="0">
      <tr>
        <td>Наименование фирмы<br /><input name="firm_name" type="text" id="firm_name" size="64" maxlength="64">
            <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/firm_name"/></xsl:attribute></input>
       </td>
      </tr>
      <tr>
        <td> E-mail <input type="text" name="e-mail" id="e-mail" >
                    <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/e-mail"/></xsl:attribute></input>
             Site <input name="url" type="text" id="url" size="26" maxlength="25">
            <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/url"/></xsl:attribute></input>
       </td>
      </tr>
      <tr>
        <td colspan="4"><input type="submit" name="action[new_firm]" id="edit" value="Создать" /> 
                        <input type="submit" name="action[edit_firm]" id="edit" value="Редакировать" />  
                        <input type="submit" name="action[del_firm]" id="edit" value="Удалить" /></td>
      </tr>
     </table>
   </td>
 </tr>
  <tr>
    <td></td>
  </tr>
  <tr>
    <td colspan="4"><p>Блок подразделений</p>
      <p>!!!</p></td>
  </tr>
  <tr>
    
    <td><table border="0">
      <tr>
        <td colspan="4">Описание<br />
            <input name="subd_name" type="text" id="subd_name" size="64" maxlength="64" >
            <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/subd_name"/></xsl:attribute></input>
            <br />
       </td>
      </tr>
      <tr>
        <td>Телефон</td>
        <td><input name="phone" type="text" id="phone" size="7" maxlength="7" >
            <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/phone"/></xsl:attribute></input>
       </td>
        <td>&nbsp;</td>
        <td></td>
      </tr>
      <tr>
        <td colspan="4">Категория
           <xsl:call-template name="menuitems">
               <xsl:with-param name="pid"  select="0" />
               <xsl:with-param name="pname" select="1"/>
          </xsl:call-template></td>
        </tr>
      <tr>
        <td colspan="2">Адресс</td>
        <td></td>
        <td>Режим работы</td>
      </tr>
      <tr>
        <td>Город</td>
        <td>
         <xsl:call-template name="town">
          <xsl:with-param name="show_all" select="0" />
        </xsl:call-template>
       </td>
        <td></td>
        <td rowspan="4"><table border="0">
            <tr>
              <td>Пн - Пт </td>
              <td>с </td>
              <td><select name="week_from_time" id="week_from_time">
                  <option value="00" selected="selected">00</option>
                  <option value="01">01</option>
                  <option value="02">02</option>
                  <option value="03">03</option>
                  <option value="04">04</option>
                  <option value="05">05</option>
                  <option value="06">06</option>
                  <option value="07">07</option>
                  <option value="08">08</option>
                  <option value="09">09</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
              </select></td>
              <td> по </td>
              <td><select name="week_to_time" id="week_to_time">
                  <option value="00" selected="selected">00</option>
                  <option value="01">01</option>
                  <option value="02">02</option>
                  <option value="03">03</option>
                  <option value="04">04</option>
                  <option value="05">05</option>
                  <option value="06">06</option>
                  <option value="07">07</option>
                  <option value="08">08</option>
                  <option value="09">09</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
              </select></td>
            </tr>
            <tr>
              <td>Сб</td>
              <td>с </td>
              <td><select name="sat_from_time" id="sat_from_time">
                  <option value="00" selected="selected">00</option>
                  <option value="01">01</option>
                  <option value="02">02</option>
                  <option value="03">03</option>
                  <option value="04">04</option>
                  <option value="05">05</option>
                  <option value="06">06</option>
                  <option value="07">07</option>
                  <option value="08">08</option>
                  <option value="09">09</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
              </select></td>
              <td> по </td>
              <td><select name="sat_to_time" id="sat_to_time">
                  <option value="00" selected="selected">00</option>
                  <option value="01">01</option>
                  <option value="02">02</option>
                  <option value="03">03</option>
                  <option value="04">04</option>
                  <option value="05">05</option>
                  <option value="06">06</option>
                  <option value="07">07</option>
                  <option value="08">08</option>
                  <option value="09">09</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
              </select></td>
            </tr>
            <tr>
              <td>Вс </td>
              <td>с </td>
              <td><select name="sun_from_time" id="sun_from_time">
                  <option value="00" selected="selected">00</option>
                  <option value="01">01</option>
                  <option value="02">02</option>
                  <option value="03">03</option>
                  <option value="04">04</option>
                  <option value="05">05</option>
                  <option value="06">06</option>
                  <option value="07">07</option>
                  <option value="08">08</option>
                  <option value="09">09</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
              </select></td>
              <td> по </td>
              <td><select name="sun_to_time" id="sun_to_time">
                  <option value="00" selected="selected">00</option>
                  <option value="01">01</option>
                  <option value="02">02</option>
                  <option value="03">03</option>
                  <option value="04">04</option>
                  <option value="05">05</option>
                  <option value="06">06</option>
                  <option value="07">07</option>
                  <option value="08">08</option>
                  <option value="09">09</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
              </select></td>
            </tr>
            <tr>
              <td>Обед</td>
              <td>с </td>
              <td><select name="break_from_time" id="break_from_time">
                  <option value="00" selected="selected">00</option>
                  <option value="01">01</option>
                  <option value="02">02</option>
                  <option value="03">03</option>
                  <option value="04">04</option>
                  <option value="05">05</option>
                  <option value="06">06</option>
                  <option value="07">07</option>
                  <option value="08">08</option>
                  <option value="09">09</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
              </select></td>
              <td> по </td>
              <td><select name="break_to_time" id="break_to_time">
                  <option value="00" selected="selected">00</option>
                  <option value="01">01</option>
                  <option value="02">02</option>
                  <option value="03">03</option>
                  <option value="04">04</option>
                  <option value="05">05</option>
                  <option value="06">06</option>
                  <option value="07">07</option>
                  <option value="08">08</option>
                  <option value="09">09</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
              </select></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td>Улица</td>
        <td><input type="text" name="street" id="street" >
            <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/street"/></xsl:attribute></input>
       </td>
        <td></td>
      </tr>
      <tr>
        <td>Дом</td>
        <td><input type="text" name="building" id="building">
            <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/building"/></xsl:attribute></input>
       </td>
        <td></td>
      </tr>
      <tr>
        <td>Оффис</td>
        <td><input type="text" name="office" id="office">
            <xsl:attribute name="value"><xsl:value-of select="/pageroot/var/office"/></xsl:attribute></input>
       </td>
        <td></td>
      </tr>
      <tr>
        <td colspan="4"><input type="submit" name="action[new_subdiv]" id="edit" value="Добавить" />
                        <input type="submit" name="action[edit_subdiv]" id="edit" value="Обновить" />
                        <input type="submit" name="action[del_subdiv]" id="edit" value="Удалить" /></td>
      </tr>
    </table></td>
  </tr>
</table>
<table border="0"><tr><td colspan="4"></td>
  </tr>
</table>
</form>
</body>
</html>
</xsl:template>
</xsl:stylesheet>