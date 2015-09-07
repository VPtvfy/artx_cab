UPDATE artex_pvl.firm  SET NAME=REPLACE(NAME,'-',' - ')  WHERE NAME REGEXP '[[:graph:]]-|-[[:graph:]]';
UPDATE artex_pvl.firm  SET NAME=REPLACE(NAME,' ,',',')   WHERE NAME REGEXP '[[:blank:]],';
UPDATE artex_pvl.firm  SET NAME=REPLACE(NAME,' -,',' -') WHERE NAME REGEXP '[[:blank:]]-,';
UPDATE artex_pvl.firm  SET NAME=REPLACE(TRIM(NAME),'  ',' ') WHERE NAME REGEXP '[[:blank:]]{2,}';

UPDATE artex_spl.firm  SET NAME=REPLACE(NAME,'-',' - ')  WHERE NAME REGEXP '[[:graph:]]-|-[[:graph:]]';
UPDATE artex_spl.firm  SET NAME=REPLACE(NAME,' ,',',')   WHERE NAME REGEXP '[[:blank:]],';
UPDATE artex_spl.firm  SET NAME=REPLACE(NAME,' -,',' -') WHERE NAME REGEXP '[[:blank:]]-,';
UPDATE artex_spl.firm  SET NAME=REPLACE(TRIM(NAME),'  ',' ') WHERE NAME REGEXP '[[:blank:]]{2,}';

UPDATE artex_ukg.firm  SET NAME=REPLACE(NAME,'-',' - ')  WHERE NAME REGEXP '[[:graph:]]-|-[[:graph:]]';
UPDATE artex_ukg.firm  SET NAME=REPLACE(NAME,' ,',',')   WHERE NAME REGEXP '[[:blank:]],';
UPDATE artex_ukg.firm  SET NAME=REPLACE(NAME,' -,',' -') WHERE NAME REGEXP '[[:blank:]]-,';
UPDATE artex_ukg.firm  SET NAME=REPLACE(TRIM(NAME),'  ',' ') WHERE NAME REGEXP '[[:blank:]]{2,}';

UPDATE artex_pvl.catalog  SET DATA='1я: асуцюкрепхъ' WHERE DATA='1я:асуцюкрепхъ';
UPDATE artex_spl.catalog  SET DATA='1я: асуцюкрепхъ' WHERE DATA='1я:асуцюкрепхъ';
UPDATE artex_ukg.catalog  SET DATA='1я: асуцюкрепхъ' WHERE DATA='1я:асуцюкрепхъ';

UPDATE artex_pvl.catalog  SET DATA='кецйюъ опнлшькеммнярэ' WHERE DATA='кецйюъ опнл - рэ';
UPDATE artex_spl.catalog  SET DATA='кецйюъ опнлшькеммнярэ' WHERE DATA='кецйюъ опнл - рэ';
UPDATE artex_ukg.catalog  SET DATA='кецйюъ опнлшькеммнярэ' WHERE DATA='кецйюъ опнл - рэ';

UPDATE artex_pvl.catalog  SET DATA='охыебюъ опнлшькеммнярэ' WHERE DATA='охыебюъ опнл - рэ';
UPDATE artex_spl.catalog  SET DATA='охыебюъ опнлшькеммнярэ' WHERE DATA='охыебюъ опнл - рэ';
UPDATE artex_ukg.catalog  SET DATA='охыебюъ опнлшькеммнярэ' WHERE DATA='охыебюъ опнл - рэ';

UPDATE artex_pvl.catalog  SET DATA='яекэяйне унгъиярбн' WHERE DATA='яекэяйне унгъиярбн (акнй)';
UPDATE artex_spl.catalog  SET DATA='яекэяйне унгъиярбн' WHERE DATA='яекэяйне унгъиярбн (акнй)';
UPDATE artex_ukg.catalog  SET DATA='яекэяйне унгъиярбн' WHERE DATA='яекэяйне унгъиярбн (акнй)';

UPDATE artex_pvl.catalog  SET DATA='яекэяйне унгъиярбн' WHERE DATA='яекэяйне унг - бн';
UPDATE artex_spl.catalog  SET DATA='яекэяйне унгъиярбн' WHERE DATA='яекэяйне унг - бн';
UPDATE artex_ukg.catalog  SET DATA='яекэяйне унгъиярбн' WHERE DATA='яекэяйне унг - бн';

DROP TABLE IF EXISTS artex_all._firm;
DROP TEMPORARY TABLE IF EXISTS artex_all._firm;
CREATE TABLE artex_all._firm 
AS 
SELECT * FROM (
        SELECT f.name firm_name,d.name div_name, t.name town, c.data class, d.street,d.building,d.bletter,d.office,d.oletter, d.phone
          FROM artex_pvl.firm f
          LEFT JOIN artex_pvl.firm_div d ON d.firm_id=f.id
          LEFT JOIN artex_pvl.town t ON t.id=d.town_id
          LEFT JOIN artex_pvl.catalog c ON c.id=d.class_id
        UNION ALL
        SELECT f.name firm_name,d.name div_name, t.name town, c.data class,d.street,d.building,d.bletter,d.office,d.oletter, d.phone 
          FROM artex_spl.firm f
          LEFT JOIN artex_spl.firm_div d ON d.firm_id=f.id
          LEFT JOIN artex_spl.town t ON t.id=d.town_id
          LEFT JOIN artex_spl.catalog c ON c.id=d.class_id
        UNION ALL
        SELECT f.name firm_name,d.name div_name, t.name town, c.data class,d.street,d.building,d.bletter,d.office,d.oletter, d.phone
          FROM artex_ukg.firm f
          LEFT JOIN artex_ukg.firm_div d ON d.firm_id=f.id
          LEFT JOIN artex_ukg.town t ON t.id=d.town_id
          LEFT JOIN artex_ukg.catalog c ON c.id=d.class_id                 
        ) a
WHERE firm_name !=''
ORDER BY 1,2,3,4,5,6,7,8,9;

DROP TABLE IF EXISTS artex_all.firm;
CREATE TABLE artex_all.firm(
  firm_id INT(6) UNSIGNED NOT NULL,
  firm_name VARCHAR(150) NOT NULL,
  firm_descr VARCHAR(1024) DEFAULT ''
  ) ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO artex_all.firm (firm_id,firm_name) VALUES (0,'');
UPDATE artex_all.firm SET firm_id =0;

ALTER TABLE artex_all.firm   
  ADD PRIMARY KEY (firm_id),
  ADD  UNIQUE INDEX unq_name (firm_name);

ALTER TABLE artex_all.firm  
AUTO_INCREMENT=1;  

ALTER TABLE artex_all.firm   
  CHANGE firm_id firm_id INT(6) UNSIGNED NOT NULL AUTO_INCREMENT;

INSERT INTO artex_all.firm(firm_name)
     SELECT distinct  firm_name
       FROM `artex_all`.`_firm`
      WHERE firm_name  !=''
      ORDER BY 1;

DROP TABLE IF EXISTS artex_all.firm_div;
CREATE TABLE artex_all.firm_div (
  firm_div_id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  firm_id INT(10) UNSIGNED DEFAULT NULL,
  item_id INT(4) UNSIGNED NOT NULL,  
  firm_div_name VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY  (firm_div_id),
  KEY idx_firm (firm_id),
  UNIQUE KEY `unq_item` (`item_id`,`firm_id`)
  ) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE artex_all.firm_div  
ADD CONSTRAINT fk_firm_div FOREIGN KEY (firm_id)  REFERENCES firm (firm_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE artex_all.firm_div  
ADD CONSTRAINT fk_item_id FOREIGN KEY (item_id) REFERENCES catalog_item(item_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE artex_all.firm_div  
AUTO_INCREMENT=1;  

INSERT INTO artex_all.firm_div(firm_id,firm_div_name,item_id)
 SELECT DISTINCT f.firm_id,d.div_name,c.item_id item_id 
   FROM artex_all.firm f
  INNER JOIN artex_all._firm d ON f.firm_name=d.firm_name
  INNER JOIN artex_all.`catalog_item` c ON c.item_name=d.class
  group by f.firm_id,c.item_id; 
 
CREATE OR REPLACE VIEW vcatalog AS 
SELECT
  c.item_id   AS item_id,
  b.pid  AS item_pid,
  c.item_name AS item_name,
  COUNT(DISTINCT t.id) AS `count`,
  COUNT(DISTINCT f.firm_id) AS stat
  FROM catalog_item c   
 INNER JOIN catalog_tree b   ON b.id = c.item_id
  LEFT JOIN catalog_tree t   ON t.pid = b.id
  LEFT JOIN firm_div f  ON f.item_id = c.item_id
GROUP BY b.pid,c.item_id
ORDER BY b.pid,c.item_id;
