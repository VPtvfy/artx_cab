<?php
global $_CFG;
$_CFG['XSL_PATH']='_xsl//';

# Account -------------------------------------------------------------------------------------------------------
$_CFG['SQL']['login']=<<<ENDSQL
update users
   SET status_id=status_id+1
 where login=:login;
update users
   set status=0,
       lastlogin=now()
 where login=:login
   and password=md5(concat(:login,:passwd))
   and ifnull(expired,now())<=now();
select *
  from users
 where login=:login
   and password=md5(concat(:login,:passwd))
   and ifnull(expired,now())<=now();
ENDSQL;

$_CFG['SQL']['create_user']=<<<ENDSQL
ENDSQL;

$_CFG['SQL']['delete_user']=<<<ENDSQL
ENDSQL;

$_CFG['SQL']['alter_user']=<<<ENDSQL
ENDSQL;

$_CFG['SQL']['lock_user']=<<<ENDSQL
ENDSQL;

$_CFG['SQL']['unlock_user']=<<<ENDSQL
ENDSQL;

# User priv ------------------------------------------------------------------------------------------------------- 

$_CFG['SQL']['grant_user_priv']=<<<ENDSQL
ENDSQL;

$_CFG['SQL']['revoke_user_priv']=<<<ENDSQL
ENDSQL;

# Basic GUI ------------------------------------------------------------------------------------------------------- 
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

# Catalog ------------------------------------------------------------------------------------------------------- 

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

$_CFG['SQL']['get_catalog_by_town']=<<<ENDSQL
select c.item_id,0 item_pid,c.item_name, 0 `count`,count(distinct i.firm_id) `stat`
  from street s
  left join firm_address a on s.street_id=a.street_id
  left join firm_div i on a.firm_id=i.firm_id
  left join catalog_item c on i.item_id=c.item_id
 where town_id=:town_id
 group by item_name
 order by item_name;
ENDSQL;

$_CFG['SQL']['find_catalog']=<<<ENDSQL
select `id`,0 pid,if (char_length(data)>3,concat(substr(data,1,1),lower(substr(data,2,64))),data) data,hidden,`count`,`stat`
  from vcatalog
 where `count`>0 or `stat`>0
   and ucase(data) like ucase(concat('%',:find_str2,'%'))
 order by if(`id`=0,1,0),pid,data;
ENDSQL;

# Search ------------------------------------------------------------------------------------------------------- 

$_CFG['SQL']['find']=<<<ENDSQL
set @keylist = ucase(:query_str);
set @key='';
create temporary table keywords
select @key:=substr(@keylist,1,instr(concat(@keylist,'|'),'|')-1) keyword,
       @keylist:=substr(@keylist,instr(concat(@keylist,'|'),'|')+1,255) dummy
  from firm
 where @keylist!='';
delete from keywords where char_length(keyword)<3;
create temporary table fresult
as
select max(if(char_length(:query_str)<3,1,relevance(ucase(:query_str),ucase(concat_ws(' ',firm_name,item_name,address,phone))))) as relevance,               
       firm_id
  from vfirm
  left join keywords k on ucase(concat_ws(' ',firm_name,item_name,address,phone)) like concat('%',k.keyword,'%')
 where (town_id=:town or :town=0)
   and (item_id=:item or :item=0)
   and (char_length(:query_str)<3 or k.keyword is not null)
 group by firm_id
having max(if(char_length(:query_str)<3,1,relevance(upper(:query_str),concat_ws(' ',firm_name,item_name,address,phone))))>0
 order by 1 desc
 limit 100; 
ENDSQL;

$_CFG['SQL']['find_firm']=<<<ENDSQL
select f.*
  from fresult r
 inner join firm f on f.firm_id=r.firm_id
 order by r.relevance desc,f.firm_name;
ENDSQL;

$_CFG['SQL']['find_item']=<<<ENDSQL
select r.firm_id,c.*
  from fresult r
 inner join firm_div d on d.firm_id=r.firm_id
 inner join catalog_item c on c.item_id=d.item_id
ENDSQL;

$_CFG['SQL']['find_address']=<<<ENDSQL
select a.address_id,r.firm_id,t.town_name, s.street_name, concat (a.building,' ',bletter) building, concat (a.office,' ',oletter) office
  from fresult r
 inner join firm_address a on a.firm_id=r.firm_id
 inner join street s on a.street_id=s.street_id
 inner join town t on s.town_id=t.town_id
 order by 2,3,4,5
ENDSQL;

$_CFG['SQL']['find_local_address']=<<<ENDSQL
select a.address_id,r.firm_id,t.town_name, s.street_name, concat (a.building,' ',bletter) building, concat (a.office,' ',oletter) office
  from fresult r
 inner join firm_address a on a.firm_id=r.firm_id
 inner join street s on a.street_id=s.street_id
 inner join town t on s.town_id=t.town_id and  t.town_id=:export_town_id
 order by 2,3,4,5
ENDSQL;

$_CFG['SQL']['find_phone']=<<<ENDSQL
select p.*
  from fresult r
 inner join firm_address a on a.firm_id=r.firm_id
 inner join firm_phone p on a.address_id=p.address_id
 order by 2,3,4,5;
ENDSQL;

# Firm ------------------------------------------------------------------------------------------------------- 

$_CFG['SQL']['autocomplete_firm']=<<<ENDSQL
drop temporary table if exists keywords;
set @keylist = ucase(:query_str);
set @key='';
create temporary table keywords
select @key:=substr(@keylist,1,instr(concat(@keylist,'|'),'|')-1) keyword,
       @keylist:=substr(@keylist,instr(concat(@keylist,'|'),'|')+1,255) dummy
  from firm
 where @keylist!='';
select f.firm_name `value`
  from firm f
 inner join  keywords k on char_length(k.keyword) and f.firm_name like concat('%',k.keyword,'%')
 group by firm_id
 order by relevance(ucase(group_concat(k.keyword separator '|')),firm_name) desc
 limit 15
ENDSQL;

$_CFG['SQL']['create_firm']=<<<ENDSQL
insert into firm (`firm_name`,`firm_descr`)
values (upper(trim(:firm_name)),:firm_descr);
select *
  from firm
 where `firm_name`=upper(trim(:firm_name));
ENDSQL;

$_CFG['SQL']['update_firm']=<<<ENDSQL
update firm
   set `name`=upper(trim(:firm_name)),`firm_description`=:firm_description
  where id =:firm_id;
ENDSQL;

$_CFG['SQL']['delete_firm']=<<<ENDSQL
delete
  from firm
 where id =:firm_id;
ENDSQL;

$_CFG['SQL']['export_firm']=<<<ENDSQL
create temporary table fresult
as
select 0 as relevance,               
       firm_id
  from vfirm
 where town_id=:export_town_id
   and item_id=:export_item_id
 group by firm_id;
ENDSQL;

# Firm div ------------------------------------------------------------------------------------------------------- 

$_CFG['SQL']['get_firm_div']=<<<ENDSQL
select d.firm_id,d.firm_div_id,c.*,d.firm_div_name
  from firm_div d
 inner join catalog_item c on c.item_id=d.item_id
 where `firm_id`=:firm_id;
ENDSQL;

$_CFG['SQL']['create_firm_div']=<<<ENDSQL
insert into firm_div (`firm_id`,`item_id`,`firm_div_name`)
select :firm_id,i.item_id,:firm_item_descr
  from catalog_item i
 where `item_name`=:firm_item_name;
ENDSQL;

$_CFG['SQL']['update_firm_div']=<<<ENDSQL
update firm_div
   set `item_id`=:firm_item_id,
       `firm_div_name`=trim(:firm_div_name)
 where `firm_div_id`=:firm_div_id;
select *
  from firm_div
 where `firm_id`=:firm_id;
ENDSQL;

$_CFG['SQL']['delete_firm_div']=<<<ENDSQL
select i.item_id into @item_id
  from catalog_item i
 where `item_name`=:firm_item_name;
delete from firm_div where firm_id=:firm_id and item_id=@item_id;
ENDSQL;

# Firm address ------------------------------------------------------------------------------------------------------- 

$_CFG['SQL']['autocomplete_street']=<<<ENDSQL
drop temporary table if exists keywords;
set @keylist = ucase(:query_str);
set @key='';
create temporary table keywords
select @key:=substr(@keylist,1,instr(concat(@keylist,'|'),'|')-1) keyword,
       @keylist:=substr(@keylist,instr(concat(@keylist,'|'),'|')+1,255) dummy
  from firm
 where @keylist!='';                                  
select s.street_id `value`, s.street_name `label`
  from street s
 inner join  keywords k on s.street_name like concat('%',k.keyword,'%') and s.town_id=:town_id
 group by s.street_name
 order by relevance(ucase(group_concat(k.keyword separator '|')),s.street_name) desc
 limit 15
ENDSQL;

$_CFG['SQL']['get_firm_address']=<<<ENDSQL
select a.firm_id,a.address_id,t.town_name, s.street_name, CONCAT (a.building,bletter) building,  CONCAT (a.office,oletter) office
  from firm_address a
 inner join street s on a.street_id=s.street_id
 inner join town t on s.town_id=t.town_id
 where firm_id=:firm_id
 order by 3,4,5,6;
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
 where `address_id`=:firm_address_id;
ENDSQL;

$_CFG['SQL']['delete_firm_address']=<<<ENDSQL
delete
  from firm_address
 where `address_id`=:firm_address_id;
ENDSQL;

# Firm phone ------------------------------------------------------------------------------------------------------- 

$_CFG['SQL']['get_firm_phone']=<<<ENDSQL
select p.*
  from firm_address a 
 inner join firm_phone p on a.address_id=p.address_id and a.firm_id=:firm_id
 order by 2,3,4,5;
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
ENDSQL;

$_CFG['SQL']['delete_firm_phone']=<<<ENDSQL
delete
  from firm_phone
 where `phone_id`=:firm_phone_id;
ENDSQL;

# Items ------------------------------------------------------------------------------------------------------- 

$_CFG['SQL']['autocomplete_item']=<<<ENDSQL
drop temporary table if exists keywords;
set @keylist = ucase(:query_str);
set @key='';
create temporary table keywords
select @key:=substr(@keylist,1,instr(concat(@keylist,'|'),'|')-1) keyword,
       @keylist:=substr(@keylist,instr(concat(@keylist,'|'),'|')+1,255) dummy
  from firm
 where @keylist!='';
select i.item_id `value`, i.item_name `label`
  from vcatalog i
 inner join  keywords k on i.item_name like concat('%',k.keyword,'%') and i.count=0
 group by i.item_name
 order by relevance(ucase(group_concat(k.keyword separator '|')),item_name) desc
 limit 15
ENDSQL;

$_CFG['SQL']['create_item']=<<<ENDSQL
insert into catalog_item(`item_name`);
set @item_id := last_insert_id();
insert into catalog_tree(`id`,`pid`)
 where (@item_id,:item_pid);
ENDSQL;

$_CFG['SQL']['rename_item']=<<<ENDSQL
update catalog_item
   set `item_name`=:item_name
 where `item_id`=:item_id;
ENDSQL;

$_CFG['SQL']['move_item']=<<<ENDSQL
update catalog_tree
   set `item_pid`=:item_pid
 where `item_id`= :item_id;
ENDSQL;

$_CFG['SQL']['find_by_id']=<<<ENDSQL
select firm_id, firm_name, email, url, vip, subdiv_id, subdiv, town_id, town, street, building, bletter, office, oletter, code, phone, class_id, class
  from v_firm
 where firm_id = :firm_id;
ENDSQL;
?>