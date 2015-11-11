drop table if exists artex_all.firm_phone;
drop table if exists artex_all.firm_address;
drop table if exists artex_all.street;

create table artex_all.street (
  street_id int(6) unsigned not null auto_increment,
  town_id int(4) unsigned default null,
  street_name varchar(100) not null,
  primary key  (street_id),
  key idx_street(street_name)
  ) engine=innodb default charset=utf8;
  
-- INSERT INTO artex_all.street(street_id,town_id,street_name)
--        VALUES (0,null,'Без адреса');

-- UPDATE artex_all.street SET street_id=0;

ALTER TABLE artex_all.street  
AUTO_INCREMENT=1;

alter table artex_all.street
  add unique index unq_street (town_id,street_name);

alter table artex_all.street 
  add constraint fk_street_town foreign key (town_id) references artex_all.town(town_id) on update cascade;

update artex_all._firm 
   set street='' 
 where CHAR_LENGTH(street)<3;

insert into artex_all.street(town_id,street_name) 
select distinct t.town_id,f.street 
  from artex_all._firm f
  left join artex_all.town t on t.town_name=f.town
 where street is not null 
   and t.town_id is not null 
--   and CHAR_LENGTH(street)>3
 order by 2,1;
 
update artex_all.street  set street_name=replace(trim(street_name),'  ',' ') where street_name regexp '[[:blank:]]{2,}';

create table artex_all.firm_address(
  address_id int(6) unsigned not null auto_increment,
  firm_id int(6) unsigned not null,
  street_id int(6) unsigned not null,
  building int(4) unsigned not null,
  bletter char(1) not null,
  office int(4) unsigned,
  oletter char(1) not null,
  description varchar(256),
  primary key (address_id));

alter table artex_all.firm_address
  add unique index unq_address (firm_id,street_id,building,bletter,office,oletter);

alter table artex_all.firm_address
  add index idx_firm_address (firm_id);

alter table artex_all.firm_address
  add constraint fk_address_street foreign key (street_id) references artex_all.street(street_id) on update cascade;

alter table artex_all.firm_address
  add constraint fk_address_firm   foreign key (firm_id)   references artex_all.firm(firm_id) on update cascade;

alter table artex_all.firm_address
  add constraint fk_firm_address   foreign key (firm_id)   references artex_all.firm(firm_id) on update cascade;


update artex_all._firm 
   set building=0 
 where building is null;
   
update artex_all._firm 
   set office=null 
 where trim(office) in ('0','');
   
update artex_all._firm 
   set bletter=upper(trim(ifnull(bletter,'')));
    
update artex_all._firm 
   set bletter=''
 where trim(bletter)='0';   

update artex_all._firm 
   set oletter=upper(trim(ifnull(oletter,'')));
    
update artex_all._firm 
   set oletter=''
 where trim(oletter)='0'; 
 
insert into artex_all.firm_address(firm_id,street_id,building,bletter,office,oletter)
select a.firm_id,s.street_id,f.building,f.bletter,f.office,f.oletter 
  from artex_all._firm f
 inner join artex_all.firm a on a.firm_name=f.firm_name
  left join artex_all.town t on t.town_name=f.town 
  left join artex_all.street s on f.street=s.street_name and s.town_id=t.town_id
 where s.street_id is not null 
 group by f.firm_name,f.town,f.street,f.building,f.bletter,ifnull(f.office,a.firm_id),f.oletter 
 order by 2,3,1;
--    on duplicate key update office=null;
 
create table artex_all.firm_phone(
  phone_id	int(6) unsigned not null auto_increment,
  address_id	int(6) unsigned not null,
  phone_type	int(1) unsigned,  
  phone_code	varchar(10),
  phone_number	varchar(10) not null,
  phone_description	varchar(256),
  primary key (phone_id));

alter table artex_all.firm_phone
  add index idx_phone_address (`address_id`);
  
-- alter table artex_all.firm_phone
--  add unique index unq_phone (`phone_type`,`phone_code`,`phone_number`);

alter table artex_all.firm_phone
add constraint fk_firm_phone_address foreign key (address_id) references artex_all.firm_address(address_id) on update cascade;

insert into artex_all.firm_phone(address_id,phone_type,phone_code,phone_number,phone_description)
select d.address_id,1,t.code,f.phone,f.div_name 
  from artex_all._firm f
  left join artex_all.firm a on a.firm_name=f.firm_name
  left join artex_all.town t on f.town=t.town_name
  left join artex_all.street s on f.street=s.street_name and s.town_id=t.town_id
  left join artex_all.firm_address d on d.firm_id=a.firm_id and d.street_id=s.street_id and d.building=f.building and d.bletter=f.bletter and ifnull(d.office,'')=ifnull(f.office,'') and d.oletter=f.oletter
 where d.address_id is not null
 group by f.firm_name,f.town,f.phone;
 
create or replace view vgfirm as 
select f.firm_id,s.town_id,c.item_id,a.address_id,p.phone_id,
       concat_ws(' ',f.firm_name, group_concat(distinct f.firm_descr), group_concat(distinct d.firm_div_name)) firm_name,
       group_concat(distinct c.item_name separator ', ') item_name,
       group_concat(distinct concat(s.street_name,' ',a.building,' ',ifnull(a.bletter,''),if(a.office>0,concat('-',a.office,' ',ifnull(a.oletter,'')),'')) separator ', ') address,
       group_concat(distinct concat('(',p.phone_code,')',phone_number,' ',phone_description) separator ', ') phone
  from artex_all.firm f
  left join artex_all.firm_div d on f.firm_id=d.firm_id
  left join artex_all.catalog_item c on c.item_id=d.item_id
  left join artex_all.firm_address a on f.firm_id=a.firm_id
  left join artex_all.street s on s.street_id=a.street_id
  left join artex_all.firm_phone p on a.address_id=p.address_id
group by f.firm_id,s.town_id,c.item_id,a.address_id,p.phone_id;

create or replace view vfirm as 
select f.firm_id,s.town_id,c.item_id,a.address_id,p.phone_id,
       concat_ws(' ',f.firm_name, f.firm_descr, d.firm_div_name) firm_name,
       c.item_name item_name,
       if(s.street_name!='',concat(s.street_name,' ',if(a.building=0,'',a.building),' ',ifnull(a.bletter,''),if(a.office>0,concat('-',a.office,' ',ifnull(a.oletter,'')),'')),'') address,
       concat('(',p.phone_code,')',phone_number,' ',phone_description) phone
  from artex_all.firm f
  left join artex_all.firm_div d on f.firm_id=d.firm_id
  left join artex_all.catalog_item c on c.item_id=d.item_id
  left join artex_all.firm_address a on f.firm_id=a.firm_id
  left join artex_all.street s on s.street_id=a.street_id
  left join artex_all.firm_phone p on a.address_id=p.address_id
 group by f.firm_id,s.town_id,c.item_id,a.address_id,p.phone_id;
    