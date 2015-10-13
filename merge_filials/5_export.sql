TRUNCATE TABLE spravo4nik.artx_categories_lang;
INSERT INTO spravo4nik.artx_categories_lang
SELECT 250+item_id id,
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
 SELECT IF (t.id=0,0,250+t.id) id,
        '' picture,
        IFNULL(v.icon,'') icon,
        IF(t.pid=0,0,250+t.pid) parent_id,
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