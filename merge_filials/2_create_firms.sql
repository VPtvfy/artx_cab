drop table if exists artex_all.firm_phone;
drop table if exists artex_all.firm_address;
drop table if exists artex_all.street;
drop table if exists artex_all.firm_div;
drop table if exists artex_all.firm;

update artex_pvl.firm  set name=replace(name,'-',' - ')  where name regexp '[[:graph:]]-|-[[:graph:]]';
update artex_pvl.firm  set name=replace(name,' ,',',')   where name regexp '[[:blank:]],';
update artex_pvl.firm  set name=replace(name,' -,',' -') where name regexp '[[:blank:]]-,';
update artex_pvl.firm  set name=replace(trim(name),'  ',' ') where name regexp '[[:blank:]]{2,}';

update artex_spl.firm  set name=replace(name,'-',' - ')  where name regexp '[[:graph:]]-|-[[:graph:]]';
update artex_spl.firm  set name=replace(name,' ,',',')   where name regexp '[[:blank:]],';
update artex_spl.firm  set name=replace(name,' -,',' -') where name regexp '[[:blank:]]-,';
update artex_spl.firm  set name=replace(trim(name),'  ',' ') where name regexp '[[:blank:]]{2,}';

update artex_ukg.firm  set name=replace(name,'-',' - ')  where name regexp '[[:graph:]]-|-[[:graph:]]';
update artex_ukg.firm  set name=replace(name,' ,',',')   where name regexp '[[:blank:]],';
update artex_ukg.firm  set name=replace(name,' -,',' -') where name regexp '[[:blank:]]-,';
update artex_ukg.firm  set name=replace(trim(name),'  ',' ') where name regexp '[[:blank:]]{2,}';

update artex_pvl.catalog  set data='1с: бухгалтери€' where data='1с:бухгалтери€';
update artex_spl.catalog  set data='1с: бухгалтери€' where data='1с:бухгалтери€';
update artex_ukg.catalog  set data='1с: бухгалтери€' where data='1с:бухгалтери€';

update artex_pvl.catalog  set data='легка€ промышленность' where data='легка€ пром - ть';
update artex_spl.catalog  set data='легка€ промышленность' where data='легка€ пром - ть';
update artex_ukg.catalog  set data='легка€ промышленность' where data='легка€ пром - ть';

update artex_pvl.catalog  set data='пищева€ промышленность' where data='пищева€ пром - ть';
update artex_spl.catalog  set data='пищева€ промышленность' where data='пищева€ пром - ть';
update artex_ukg.catalog  set data='пищева€ промышленность' where data='пищева€ пром - ть';

update artex_pvl.catalog  set data='сельское хоз€йство' where data='сельское хоз€йство (блок)';
update artex_spl.catalog  set data='сельское хоз€йство' where data='сельское хоз€йство (блок)';
update artex_ukg.catalog  set data='сельское хоз€йство' where data='сельское хоз€йство (блок)';

update artex_pvl.catalog  set data='сельское хоз€йство' where data='сельское хоз - во';
update artex_spl.catalog  set data='сельское хоз€йство' where data='сельское хоз - во';
update artex_ukg.catalog  set data='сельское хоз€йство' where data='сельское хоз - во';

drop table if exists artex_all._firm;
drop temporary table if exists artex_all._firm;
create table artex_all._firm 
as 
select * from (
        select f.name firm_name,d.name div_name, t.name town, c.data class, d.street,d.building,d.bletter,d.office,d.oletter, d.phone
          from artex_pvl.firm f
          left join artex_pvl.firm_div d on d.firm_id=f.id
          left join artex_pvl.town t on t.id=d.town_id
          left join artex_pvl.catalog c on c.id=d.class_id
        union all
        select f.name firm_name,d.name div_name, t.name town, c.data class,d.street,d.building,d.bletter,d.office,d.oletter, d.phone 
          from artex_spl.firm f
          left join artex_spl.firm_div d on d.firm_id=f.id
          left join artex_spl.town t on t.id=d.town_id
          left join artex_spl.catalog c on c.id=d.class_id
        union all
        select f.name firm_name,d.name div_name, t.name town, c.data class,d.street,d.building,d.bletter,d.office,d.oletter, d.phone
          from artex_ukg.firm f
          left join artex_ukg.firm_div d on d.firm_id=f.id
          left join artex_ukg.town t on t.id=d.town_id
          left join artex_ukg.catalog c on c.id=d.class_id                 
        ) a
where firm_name !=''
order by 1,2,3,4,5,6,7,8,9;

alter table `artex_all`.`_firm` add index `_firm_name` (`firm_name`);

update artex_all._firm f
   set f.class=(select distinct ifnull(spr_name,f.class) from artex_all.catalog_map where upper(art_name)=upper(f.class))
 where upper(f.class) in (select upper(art_name) from artex_all.catalog_map);


drop table if exists artex_all.firm;
create table artex_all.firm(
  firm_id int(6) unsigned not null,
  firm_type int (1) unsigned default 0,
  firm_name varchar(150) not null,
  firm_descr varchar(1024) default ''
  ) engine=innodb default charset=utf8;

insert into artex_all.firm (firm_id,firm_name) values (0,'');
update artex_all.firm set firm_id =0;

alter table artex_all.firm   
  add primary key (firm_id),
  add  unique index unq_name (firm_type,firm_name);

alter table artex_all.firm  
auto_increment=1;  

alter table artex_all.firm   
  change firm_id firm_id int(6) unsigned not null auto_increment;

insert into artex_all.firm(firm_name)
     select distinct  firm_name
       from `artex_all`.`_firm`
      where firm_name  !=''
      order by 1;

drop table if exists artex_all.firm_div;
create table artex_all.firm_div (
  firm_div_id int(10) unsigned not null auto_increment,
  firm_id int(10) unsigned default null,
  item_id int(4) unsigned not null,  
  firm_div_name varchar(100) default null,
  primary key  (firm_div_id),
  key idx_firm (firm_id),
  unique key `unq_item` (`item_id`,`firm_id`)
  ) engine=innodb default charset=utf8;

alter table artex_all.firm_div  
add constraint fk_firm_div foreign key (firm_id)  references artex_all.firm (firm_id) on update cascade on delete restrict;

alter table artex_all.firm_div  
add constraint fk_item_id foreign key (item_id) references artex_all.catalog_item(item_id) on update cascade on delete restrict;

alter table artex_all.firm_div  
auto_increment=1;  

insert into artex_all.firm_div(firm_id,firm_div_name,item_id)
 select distinct f.firm_id,d.div_name,c.item_id item_id 
   from artex_all.firm f
  inner join artex_all._firm d on f.firm_name=d.firm_name
  inner join artex_all.catalog_item c on c.item_name=d.class
  group by f.firm_id,c.item_id; 
 
create or replace view artex_all.vcatalog as 
select
  c.item_id   as item_id,
  b.pid  as item_pid,
  c.item_name as item_name,
  count(distinct t.id) as `count`,
  count(distinct f.firm_id) as stat
  from artex_all.catalog_item c   
 inner join artex_all.catalog_tree b   on b.id = c.item_id
  left join artex_all.catalog_tree t   on t.pid = b.id
  left join artex_all.firm_div f  on f.item_id = c.item_id
group by b.pid,c.item_id
order by b.pid,c.item_id;
