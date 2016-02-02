DROP TABLE IF EXISTS artex_all.firm_phone;
DROP TABLE IF EXISTS artex_all.firm_address;
DROP TABLE IF EXISTS artex_all.street;
DROP TABLE IF EXISTS artex_all.firm_div;
DROP TABLE IF EXISTS artex_all.firm;
DROP TABLE IF EXISTS artex_all.catalog_tree;
DROP TABLE IF EXISTS artex_all.catalog_item;

DROP TEMPORARY TABLE IF EXISTS pvl_bad_id;
DROP TEMPORARY TABLE IF EXISTS spl_bad_id;
DROP TEMPORARY TABLE IF EXISTS ukg_bad_id;

CREATE TEMPORARY TABLE pvl_bad_id AS 
SELECT c1.id
  FROM artex_pvl.catalog c1
  LEFT JOIN artex_pvl.catalog c2 ON c1.id=c2.pid 
  LEFT JOIN artex_pvl.firm_div d ON d.class_id=c1.id  
 WHERE c1.id>0 AND c2.id IS NULL AND d.id IS NULL 
 ORDER BY c1.pid,c1.id;
 
CREATE TEMPORARY TABLE spl_bad_id AS 
SELECT c1.*
  FROM artex_spl.catalog c1
  LEFT JOIN artex_spl.catalog c2 ON c1.id=c2.pid 
  LEFT JOIN artex_spl.firm_div d ON d.class_id=c1.id 
 WHERE c1.id>0 AND c2.id IS NULL AND d.id IS NULL 
 ORDER BY c1.pid,c1.id;

CREATE TEMPORARY TABLE ukg_bad_id AS 
SELECT c1.*
  FROM artex_ukg.catalog c1
  LEFT JOIN artex_ukg.catalog c2 ON c1.id=c2.pid 
  LEFT JOIN artex_ukg.firm_div d ON d.class_id=c1.id 
 WHERE c1.id>0 AND c2.id IS NULL AND d.id IS NULL 
 ORDER BY c1.pid,c1.id;

DELETE FROM artex_pvl.catalog WHERE id IN (SELECT id FROM pvl_bad_id ORDER BY 1 DESC);
DELETE FROM artex_spl.catalog WHERE id IN (SELECT id FROM spl_bad_id ORDER BY 1 DESC);
DELETE FROM artex_ukg.catalog WHERE id IN (SELECT id FROM ukg_bad_id ORDER BY 1 DESC);
   
DROP TEMPORARY TABLE IF EXISTS pvl_bad_id;
DROP TEMPORARY TABLE IF EXISTS spl_bad_id;
DROP TEMPORARY TABLE IF EXISTS ukg_bad_id;

UPDATE artex_pvl.catalog  SET DATA=UPPER(DATA);
UPDATE artex_spl.catalog  SET DATA=UPPER(DATA);
UPDATE artex_ukg.catalog  SET DATA=UPPER(DATA);

UPDATE artex_pvl.catalog  SET DATA=REPLACE(DATA,'-',' - ') WHERE DATA REGEXP '[[:graph:]]-|-[[:graph:]]';
UPDATE artex_pvl.catalog  SET DATA=REPLACE(DATA,' ,',',') WHERE DATA REGEXP '[[:blank:]],';
UPDATE artex_pvl.catalog  SET DATA=REPLACE(DATA,' -,',' -') WHERE DATA REGEXP '[[:blank:]]-,';
UPDATE artex_pvl.catalog  SET DATA=REPLACE(TRIM(DATA),'  ',' ') WHERE DATA REGEXP '[[:blank:]]{2,}';

UPDATE artex_spl.catalog  SET DATA=REPLACE(DATA,'-',' - ') WHERE DATA REGEXP '[[:graph:]]-|-[[:graph:]]';
UPDATE artex_spl.catalog  SET DATA=REPLACE(DATA,' ,',',') WHERE DATA REGEXP '[[:blank:]],';
UPDATE artex_spl.catalog  SET DATA=REPLACE(DATA,' -,',' -') WHERE DATA REGEXP '[[:blank:]]-,';
UPDATE artex_spl.catalog  SET DATA=REPLACE(TRIM(DATA),'  ',' ') WHERE DATA REGEXP '[[:blank:]]{2,}';

UPDATE artex_ukg.catalog  SET DATA=REPLACE(DATA,'-',' - ') WHERE DATA REGEXP '[[:graph:]]-|-[[:graph:]]';
UPDATE artex_ukg.catalog  SET DATA=REPLACE(DATA,' ,',',') WHERE DATA REGEXP '[[:blank:]],';
UPDATE artex_ukg.catalog  SET DATA=REPLACE(DATA,' -,',' -') WHERE DATA REGEXP '[[:blank:]]-,';
UPDATE artex_ukg.catalog  SET DATA=REPLACE(TRIM(DATA),'  ',' ') WHERE DATA REGEXP '[[:blank:]]{2,}';

DROP TEMPORARY TABLE IF EXISTS artex_all._tree;
DROP TABLE IF EXISTS artex_all._tree;
CREATE TABLE artex_all._tree AS 
SELECT n2.name `name`,n.name c1,n2.name c2, NULL c3, NULL c4
  FROM artex_all.`artx_categories` c
  LEFT JOIN `artx_categories_lang` n ON c.id=n.id
  LEFT JOIN `artx_categories` c2  ON c.id=c2.parent_id
  LEFT JOIN `artx_categories_lang` n2 ON c2.id=n2.id  
 WHERE c.parent_id =0  
 ORDER BY c1,c2,c3,c4;

 UPDATE _tree
   SET  c4=''
 WHERE c3=c4 AND c4!='';

UPDATE _tree
   SET c3=''
 WHERE c2=c3 AND c3!='';

UPDATE _tree
   SET c2=''
 WHERE c1=c2 AND c2!='';

CREATE TABLE artex_all.catalog_item(
  item_id INT(4) UNSIGNED AUTO_INCREMENT,
  item_name VARCHAR(64),
  PRIMARY KEY (item_id))
ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO artex_all.catalog_item(item_name)
        VALUES ('Рубрики');

UPDATE artex_all.catalog_item SET item_id=0;

ALTER TABLE artex_all.catalog_item  
ADD  UNIQUE INDEX unq_name (item_name);

ALTER TABLE artex_all.catalog_item  
AUTO_INCREMENT=1;


CREATE TABLE artex_all.catalog_tree(
  id INT(4) UNSIGNED NOT NULL,
  pid INT(4)UNSIGNED NOT NULL,
  PRIMARY KEY (id,pid))
ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO artex_all.catalog_tree(id,pid)
        VALUES (0,0);       

UPDATE artex_all.catalog_tree SET id=0,pid=0;

ALTER TABLE artex_all.catalog_tree  
ADD CONSTRAINT fk_id FOREIGN KEY (id)   REFERENCES artex_all.catalog_item(item_id) ON UPDATE CASCADE;  
ALTER TABLE artex_all.catalog_tree  
ADD CONSTRAINT fk_pid FOREIGN KEY (pid) REFERENCES artex_all.catalog_item(item_id) ON UPDATE CASCADE;  
-- add constraint fk_pid foreign key (pid) references artex_all.catalog_tree(item_id) on update cascade;  

INSERT INTO artex_all.catalog_item(item_name)
select DISTINCT h.c1
  FROM artex_all._tree h
  left join artex_all._tree t on t.c1=h.c2 or t.c1=h.c3 or t.c1=h.c4
 WHERE t.name is null and h.c1!='' and h.c1!='Рубрики'
ORDER BY 1;

insert INTO artex_all.catalog_item(item_name) 
SELECT DISTINCT h.c2 
  FROM artex_all._tree h 
  left JOIN artex_all.catalog_item i on h.c2=i.item_name     
 INNER JOIN artex_all.catalog_item c ON h.c1=c.item_name  
 WHERE  h.c2!='' and i.item_name is null
ORDER BY 1;

INSERT INTO artex_all.catalog_item(item_name)
SELECT DISTINCT h.c3 
  FROM artex_all._tree h
  left JOIN artex_all.catalog_item i on h.c3=i.item_name     
 INNER JOIN artex_all.catalog_item c ON h.c2=c.item_name
 WHERE h.c3!='' and i.item_name is null
ORDER BY 1;

INSERT INTO artex_all.catalog_item(item_name)
SELECT DISTINCT h.c4 FROM artex_all._tree h 
  left JOIN artex_all.catalog_item i on h.c4=i.item_name     
 INNER JOIN artex_all.catalog_item c ON h.c3=c.item_name
WHERE h.c4!=''  and i.item_name is null
ORDER BY 1;

INSERT INTO artex_all.catalog_tree (pid,id)
SELECT DISTINCT 0,c.item_id
 FROM artex_all._tree h 
 LEFT JOIN  artex_all.catalog_item c ON c.item_name =h.c1
where c.item_id>0;

INSERT INTO artex_all.catalog_tree (pid,id)
SELECT DISTINCT c1.item_id,c2.item_id
  FROM artex_all._tree h  
 INNER JOIN artex_all.catalog_item c1 ON c1.item_name =h.c1
 INNER JOIN artex_all.catalog_item c2 ON c2.item_name =h.c2
 where c1.item_id!=0
 ORDER BY 1,2;

INSERT INTO artex_all.catalog_tree (pid,id)
SELECT DISTINCT c2.item_id,c3.item_id
  FROM  artex_all._tree h  
 INNER  JOIN artex_all.catalog_item c2 ON c2.item_name =h.c2
 INNER  JOIN artex_all.catalog_item c3 ON c3.item_name =h.c3
ORDER BY 1,2 ;

INSERT INTO artex_all.catalog_tree (pid,id)
SELECT DISTINCT c3.item_id,c4.item_id
  FROM  artex_all._tree h  
 INNER  JOIN artex_all.catalog_item c3 ON c3.item_name =h.c3
 INNER  JOIN artex_all.catalog_item c4 ON c4.item_name =h.c4
 WHERE  (c3.item_id,c4.item_id) NOT IN (SELECT pid,id FROM artex_all.catalog_tree)
 ORDER BY 1,2 ;
 
DELETE FROM artex_all.catalog_tree WHERE id=pid and id>0;

 SELECT c.item_id,h.* 
   FROM artex_all.catalog_tree ch 
   LEFT JOIN artex_all.catalog_item c ON ch.id=c.item_id  
   LEFT JOIN artex_all._tree h  ON h.name=c.item_name
 WHERE ch.id=ch.pid
 ORDER BY 2,3,4,5,6;

SELECT h1.id,
       h2.id,
       h3.id,
       h4.id,
       c1.item_name  c1, 
       c2.item_name c2, 
       c3.item_name c3, 
       c4.item_name c4 
  FROM artex_all.catalog_tree h1
  LEFT JOIN artex_all.catalog_item c1 ON c1.item_id=h1.id
  LEFT JOIN artex_all.catalog_tree h2 ON h2.pid=h1.id
  LEFT JOIN artex_all.catalog_item c2 ON c2.item_id=h2.id  
  LEFT JOIN artex_all.catalog_tree h3 ON h3.pid=h2.id
  LEFT JOIN artex_all.catalog_item c3 ON c3.item_id=h3.id  
  LEFT JOIN artex_all.catalog_tree h4 ON h4.pid=h3.id
  LEFT JOIN artex_all.catalog_item c4 ON c3.item_id=h4.id  
 WHERE h1.id>0 AND h1.pid=0
 ORDER BY c1.item_id,c2.item_id,c3.item_id,c4.item_id;

 