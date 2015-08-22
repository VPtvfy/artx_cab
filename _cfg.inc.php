<?
global $_CFG;
$_CFG['XSL_PATH']='_xsl\\';

$_CFG['SQL']['login']=<<<ENDSQL
update users
   SET status_id=status_id+1
 where login=:login;
update users
   set status=0,
       lastlogin=now()
 where login=:login
   and password=md5(concat(:login,:passwd));
select *
  from users
 where login=:login
   and password=md5(concat(:login,:passwd))
   and ifnull(expired,now()<=now());
ENDSQL;

$_CFG['SQL']['get_town']=<<<ENDSQL
select *
  from town
 order by 2;
ENDSQL;

$_CFG['SQL']['get_alpha']=<<<ENDSQL
select distinct if (upper(left(item_name,1))>='А',upper(left(item_name,1)),'*') sym
  from catalog_item
 order by upper(left(item_name,1));
ENDSQL;

$_CFG['SQL']['get_catalog']=<<<ENDSQL
select id,pid,if (char_length(data)>3,concat(substr(data,1,1),lower(substr(data,2,64))),data) data,hidden,`count`,`stat`
  from vcatalog
 order by if(`id`=0,1,0),data;
ENDSQL;

$_CFG['SQL']['get_catalog_by_id']=<<<ENDSQL
select distinct c.item_id,c.item_pid,if (char_length(c.item_name)>3,concat(substr(c.item_name,1,1),lower(substr(c.item_name,2,64))),c.item_name) item_name,c.`count`,c.`stat`
  from catalog_tree c1
 inner join catalog_tree c2 on c2.id=c1.pid and c1.id=:item
 inner join catalog_tree c3 on c3.id=c2.pid
 inner join catalog_tree c4 on c4.id=c3.pid
 inner join vcatalog c on c.item_id=c1.id or c.item_id=c2.id or c.item_id=c3.id or c.item_id=c4.id
 order by if(c.item_id=0,1,0),c.item_pid,c.item_name;
ENDSQL;

$_CFG['SQL']['get_catalog_by_pid']=<<<ENDSQL
select distinct c.item_id,c.item_pid,if (char_length(c.item_name)>3,concat(substr(c.item_name,1,1),lower(substr(c.item_name,2,64))),c.item_name) item_name,c.`count`,c.`stat`
  from catalog_tree c1
 inner join catalog_tree c2 on c2.id=c1.pid and c1.id=:item
 inner join catalog_tree c3 on c3.id=c2.pid
 inner join catalog_tree c4 on c4.id=c3.pid
 inner join vcatalog c on c.item_pid=c1.id or c.item_id=c1.id or c.item_id=c2.id or c.item_id=c3.id or c.item_id=c4.id
 where c.`count`>0 or c.stat>0
 order by if(c.item_id=0,1,0),c.item_pid,c.item_name;
ENDSQL;

$_CFG['SQL']['get_catalog_by_alpha']=<<<ENDSQL
select item_id,0 item_pid,if (char_length(item_name)>3,concat(substr(item_name,1,1),lower(substr(item_name,2,64))),item_name) item_name,`count`,`stat`
  from vcatalog
 where (if (upper(left(item_name,1))>='А',upper(left(item_name,1)),'*') = upper(left(:alpha,1)) and `stat`>0) or item_id=0
 group by item_name
 order by if(`item_id`=0,1,0),item_name;
ENDSQL;

$_CFG['SQL']['find_catalog']=<<<ENDSQL
select `id`,0 pid,if (char_length(data)>3,concat(substr(data,1,1),lower(substr(data,2,64))),data) data,hidden,`count`,`stat`
  from vcatalog
 where `count`>0 or `stat`>0
   and ucase(data) like ucase(concat('%',:find_str2,'%'))
 order by if(`id`=0,1,0),pid,data;
ENDSQL;

$_CFG['SQL']['find_firm']=<<<ENDSQL
select f.*
  from fresult r
 inner join firm f on f.firm_id=r.firm_id
order by r.relevance desc;
ENDSQL;

$_CFG['SQL']['find_item']=<<<ENDSQL
select r.firm_id,c.*
  from fresult r
 inner join firm_div d on d.firm_id=r.firm_id
 inner join catalog_item c on c.item_id=d.item_id
ENDSQL;

$_CFG['SQL']['find_address']=<<<ENDSQL
SELECT r.firm_id,t.town_name, s.street_name, CONCAT (a.building,bletter) building,  CONCAT (a.office,oletter) office
  from fresult r
 INNER JOIN firm_address a ON a.firm_id=r.firm_id
 INNER JOIN street s ON a.street_id=s.street_id
 INNER JOIN town t ON s.town_id=t.town_id
ENDSQL;

$_CFG['SQL']['find_phone']=<<<ENDSQL
select p.*
  from fresult r
 inner join firm_phone p on p.firm_id=r.firm_id;
ENDSQL;

# Firm

$_CFG['SQL']['create_firm']=<<<ENDSQL
insert into firm (`firm_name`,`firm_descr`)
values (upper(trim(:new_firm_name)),:new_firm_descr);
select *
  from firm
 where `firm_name`=upper(trim(:new_firm_name));
ENDSQL;

$_CFG['SQL']['update_firm']=<<<ENDSQL
update firm
   set `name`=upper(trim(:new_firm_name)),`firm_description`=:new_firm_description
  where id =:new_firm_id;
ENDSQL;

$_CFG['SQL']['delete_firm']=<<<ENDSQL
delete
  from firm
 where id =:firm_id;
ENDSQL;

# Firm div

$_CFG['SQL']['autocomplete_item']=<<<ENDSQL
drop temporary table if exists keywords;
set @keylist = ucase(:query_str);
set @key='';
create temporary table keywords
select @key:=substr(@keylist,1,instr(concat(@keylist,'|'),'|')-1) keyword,
       @keylist:=substr(@keylist,instr(concat(@keylist,'|'),'|')+1,255) dummy
from  firm
where @keylist!='';
select i.item_id `value`, i.item_name `label`
  from vcatalog i
 inner join  keywords k on i.item_name like concat('%',k.keyword,'%') and i.count=0
 group by i.item_name
 order by relevance(ucase(group_concat(k.keyword separator '|')),item_name) desc
 limit 15
ENDSQL;

$_CFG['SQL']['get_firm_div']=<<<ENDSQL
select d.firm_id,d.firm_div_id,c.*,d.firm_div_name
  from firm_div d
 inner join catalog_item c on c.item_id=d.item_id
 where `firm_id`=:new_firm_id;
ENDSQL;

$_CFG['SQL']['create_firm_div']=<<<ENDSQL
insert into firm_div (`firm_id`,`item_id`,`firm_div_name`)
select :new_firm_id,i.item_id,:new_firm_item_descr
  from catalog_item i
 where `item_name`=:new_firm_item_name;
ENDSQL;

$_CFG['SQL']['update_firm_div']=<<<ENDSQL
update firm_div
   set `item_id`=:firm_item_id,
       `firm_div_name`=trim(:firm_div_name)
 where `firm_div_id`=:new_firm_div_id;
select *
  from firm_div
 where `firm_id`=:new_firm_id;
ENDSQL;

$_CFG['SQL']['delete_firm_div']=<<<ENDSQL
delete
  from firm_div
 where `firm_div_id`=abs(:firm_div_id);
select *
  from firm_div
 where `firm_id`=:firm_id;
ENDSQL;

# Firm address

$_CFG['SQL']['get_firm_address']=<<<ENDSQL
select *
  from firm_address
 where `firm_id`=:new_firm_id;
ENDSQL;

$_CFG['SQL']['create_firm_address']=<<<ENDSQL
insert into firm_address (`firm_id`,`town_id`,`street_id`,`building`,`office`,`bletter`,`oletter`,`description`)
values (:firm_id,:firm_town_id,:firm_street_id,:firm_building,:firm_office,firm_bletter,firm_oletter,:firm_description);
ENDSQL;

$_CFG['SQL']['update_firm_address']=<<<ENDSQL
update firm_address
   set `town_id`=:firm_town_id,
       `street_id`=:firm_street_id,
       `building`=:firm_building,
       `office`=:firm_office,
       `bletter`=firm_bletter,
       `oletter`=firm_oletter,
       `description`=:firm_description
 where `firm_div_id`=:firm_div_id;
ENDSQL;

$_CFG['SQL']['delete_firm_address']=<<<ENDSQL
delete
  from firm_address
 where `address_id`=:firm_address_id;
select *
  from firm_address
 where `firm_id`=:firm_id;
ENDSQL;

# Firm phone

$_CFG['SQL']['get_firm_phone']=<<<ENDSQL
select *
  from firm_phone
 where `firm_id`=:new_firm_id;
ENDSQL;

$_CFG['SQL']['create_firm_phone']=<<<ENDSQL
insert into firm_phone (`firm_id`,`phone_type`,`phone_code`,`phone_number`,`phone_description`)
values (:firm_id,:phone_type,:phone_code,:phone_number,:phone_description);
select *
  from firm_phone
 where `firm_id`=:firm_id;
ENDSQL;

$_CFG['SQL']['update_firm_phone']=<<<ENDSQL
update firm_phone
   set `phone_type`=:phone_type,
       `phone_code`=:phone_code,
       `phone_number`=:phone_number,
       `phone_description`= :phone_description
 where `phone_id`=:firm_phone_id;
select *
  from firm_phone
 where `firm_id`=:firm_id;
ENDSQL;

$_CFG['SQL']['delete_firm_phone']=<<<ENDSQL
delete
  from firm_phone
 where `phone_id`=:firm_phone_id;
select *
  from firm_phone
 where `firm_id`=:firm_id;
ENDSQL;

# Items

$_CFG['SQL']['create_item']=<<<ENDSQL
insert into catalog_item(`item_name`);
set @item_id := last_insert_id();
insert into catalog_tree(`id`,`pid`)
 where (@item_id,:item_pid);
ENDSQL;

$_CFG['SQL']['rename_item']=<<<ENDSQL
update catalog_item
   set `item_name`=:item_name
 where `item_id`=item_id;
ENDSQL;

$_CFG['SQL']['move_item']=<<<ENDSQL
update catalog_tree
   set `item_pid`=:item_pid
 where `item_id`= item_id;
ENDSQL;

$_CFG['SQL']['find_by_id']=<<<ENDSQL
select firm_id, firm_name, email, url, vip, subdiv_id, subdiv, town_id, town, street, building, bletter, office, oletter, code, phone, class_id, class
  from v_firm
 where firm_id = :firm_id;
ENDSQL;

$_CFG['SQL']['find_by_class']=<<<ENDSQL
select firm_id, firm_name, email, url, vip, subdiv_id, subdiv, town_id, town, street, building, bletter, office, oletter, code, phone, class_id, class
  from v_firm
 where (class_id=:class_id or :class_id=0)
   and (town_id =:town_id or :town_id=0)
 order by firm_name,subdiv;
ENDSQL;

$_CFG['SQL']['find']=<<<ENDSQL
drop temporary table if exists fresult;
create temporary table fresult
as
select distinct if(length(:query_str)<3,1,relevance(upper(:query_str),concat_ws(' ',f.firm_name,f.item_name,f.address,f.phone))) as relevance,f.firm_id
  from (select firm_id,
               item_name,
               address,
               phone,
               firm_name
          from vfirm
         where (town_id=:town or :town=0)
           and (item_id=:item or :item=0)) f
 where if(length(:query_str)<3,1,relevance(upper(:query_str),concat_ws(' ',f.firm_name,f.item_name,f.address,f.phone)))>0
 limit 100;
ENDSQL;

$_CFG['SQL']['find']=<<<ENDSQL
drop temporary table if exists keywords;
drop temporary table if exists fresult;
set @keylist = ucase(:query_str);
set @key='';
create temporary table keywords
select @key:=substr(@keylist,1,instr(concat(@keylist,'|'),'|')-1) keyword,
       @keylist:=substr(@keylist,instr(concat(@keylist,'|'),'|')+1,255) dummy
from  firm
where @keylist!='';
delete from keywords where LENGTH(keyword)<3;
select * from keywords;
select :query_str from keywords;

create temporary table fresult
as
SELECT relevance,firm_id
  FROM (SELECT IF(LENGTH(:query_str)<3,1,relevance(UPPER(:query_str),CONCAT_WS(' ',firm_name,item_name,address,phone))) AS relevance,               
               firm_id
          FROM vfirm
         INNER JOIN keywords k ON CONCAT_WS(' ',firm_name,item_name,address,phone) LIKE CONCAT('%',k.keyword,'%')
         WHERE (town_id=:town OR :town=0)
           AND (item_id=:item OR :item=0)) f
 ORDER BY 1 DESC
 LIMIT 100;
ENDSQL;

$_CFG['SQL']['find']=<<<ENDSQL
set @keylist = ucase(:query_str);
set @key='';
create temporary table keywords
select @key:=substr(@keylist,1,instr(concat(@keylist,'|'),'|')-1) keyword,
       @keylist:=substr(@keylist,instr(concat(@keylist,'|'),'|')+1,255) dummy
from  firm
where @keylist!='';
delete from keywords where length(keyword)<3;
create temporary table fresult
as
select sum(if(length(:query_str)<3,1,relevance(upper(:query_str),concat_ws(' ',firm_name,item_name,address,phone)))) as relevance,               
               firm_id
          from vfirm
          left join keywords k on concat_ws(' ',firm_name,item_name,address,phone) like concat('%',k.keyword,'%')
         where (town_id=:town or :town=0)
           and (item_id=:item or :item=0)
           and (length(:query_str)<3 or k.keyword is not null)
group by firm_id
having sum(if(length(:query_str)<3,1,relevance(upper(:query_str),concat_ws(' ',firm_name,item_name,address,phone))))>0
order by 1 desc
limit 100; 
ENDSQL;

$_CFG['SQL']['autocomplete_firm']=<<<ENDSQL
DROP TEMPORARY TABLE IF exists keywords;
SET @keylist = UCASE(:query_str);
SET @key='';
CREATE TEMPORARY TABLE keywords
SELECT @key:=SUBSTR(@keylist,1,INSTR(CONCAT(@keylist,'|'),'|')-1) keyword,
       @keylist:=SUBSTR(@keylist,INSTR(CONCAT(@keylist,'|'),'|')+1,255) dummy
FROM  firm
WHERE @keylist!='';
SELECT f.firm_name `value`
  FROM firm f
 INNER JOIN  keywords k ON f.firm_name LIKE CONCAT('%',k.keyword,'%')
 GROUP BY firm_id
 ORDER BY relevance(UCASE(GROUP_CONCAT(k.keyword SEPARATOR '|')),firm_name) DESC
 LIMIT 15
ENDSQL;


?>