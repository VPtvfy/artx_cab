TRUNCATE TABLE spravo4nik.artx_categories_lang;
INSERT INTO spravo4nik.artx_categories_lang
SELECT item_id id,
       'ru' lang_id,
       item_name NAME,   
       item_name description,
       item_name page_title,
       item_name meta_keyword,
       item_name meta_description          
  FROM artex_all.catalog_item
 WHERE item_id>0    
 ORDER BY 1;
 

TRUNCATE TABLE spravo4nik.artx_categories;
ALTER TABLE `spravo4nik`.`artx_categories`   
  CHANGE `id` `id` INT(11) NOT NULL;
INSERT INTO spravo4nik.artx_categories
 SELECT IF (t.id=0,0,t.id) id,
        '' picture,
        IFNULL(v.icon,'') icon,
        IF(t.pid=0,0,t.pid) parent_id,
        1 fieldset,
        0 order_no,
        0 groups,
        0 ads,
        IF(pid=0,1,2) `level`
   FROM artex_all.catalog_tree t 
   LEFT JOIN artex_all.`catalog_item` c ON t.id=c.item_id 
   LEFT JOIN artex_all.`artx_categories_lang` a ON c.item_name=a.name
   LEFT JOIN artex_all.`artx_categories` v ON  a.id=v.id AND v.icon IS NOT NULL 
--  where t.id>0  
  GROUP BY t.id
  ORDER BY IF(t.pid=0,t.id,t.pid),t.id;
  
SET @ord:=0; 
UPDATE spravo4nik.artx_categories SET order_no=@ord:=@ord+1  

truncate table spravo4nik.artx_ads;
insert into spravo4nik.artx_ads
select t.town_id*100000+f.firm_id id,
       0 user_id,
       null category_id,
       1 package_id,
       0 usr_pkg,
       sysdate() date_addes,
       '0000-00-00' date_expires,
       f.firm_name title,
       firm_descr description,
       -1 price,
       null currency,
       null meta_description,
       null meta_keyword,
       0 sold,
       0 rented,
       0 viewed,
       1 user_approved,
       1 active,
       1 pending,
       0 featured,
       0 highlited,
       0 priority,
       null video,
       0 rating,
       'ru' language,
       0 no_rating,
       t.town_name city,
       trim(concat(s.street_name,' ',building,' ',ifnull(bletter,''),' ',ifnull(office,''),' ',ifnull(oletter,''))) adress,
       'ò' hdhex,
       '' _,
       '' email,
       null ekdno,
       null doptel,
       null dotel2,
       null mobtel,
       a.address_id _1,
       f.firm_id _2,
       null _3,
       null _4,
       0 weight 
  from artex_all.firm f
  inner join artex_all.firm_address a on  a.firm_id=f.firm_id
  inner join artex_all.street s on a.street_id=s.street_id
  inner join artex_all.town t on t.town_id = s.town_id
  group by f.firm_id,t.town_id;
  
  
  update spravo4nik.artx_ads f
     set hdhex=(select concat('ò',t.code,p.phone_number) 
                  from artex_all.firm_phone p 
                  left join artex_all.firm_address a on p.address_id=a.address_id 
                  left join artex_all.street s on a.street_id=s.street_id 
                  left join artex_all.town t on s.town_id=t.town_id  
                 where p.address_id=f._1 
                 group by p.address_id);
                 

truncate table spravo4nik.artx_cat_ads;
SET @id:=0; 
insert into spravo4nik.artx_cat_ads
select @id:=@id+1 id,
       d.item_id id_cat,
       f.id id_ads 
 from spravo4nik.artx_ads f
 left join artex_all.firm_div d on f._2=d.firm_id

                 
                 