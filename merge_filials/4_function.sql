DROP FUNCTION  IF EXISTS `artex_all`.`relevance`;
DELIMITER $$
CREATE FUNCTION `artex_all`.`relevance`(pattern VARCHAR(255), str VARCHAR(255)) RETURNS INT(3) DETERMINISTIC
       BEGIN   
        DECLARE rel INT(3);
        DECLARE ptrn VARCHAR(255);
        SET rel=0;
        WHILE pattern!='' DO
         SET ptrn=SUBSTR(pattern,1,INSTR(CONCAT(pattern,'|'),'|')-1);
         SET pattern=SUBSTR(pattern,INSTR(CONCAT(pattern,'|'),'|')+1,255);
         IF str REGEXP CONCAT('[[:<:]]',ptrn,'[[:>:]]') THEN SET rel=rel+4;
         ELSEIF str REGEXP CONCAT('^',ptrn) THEN SET rel=rel+4;
         ELSEIF str REGEXP CONCAT('[[:<:]]',ptrn,'.*[[:>:]]') THEN SET rel=rel+2;
         ELSEIF str REGEXP ptrn THEN SET rel=rel+1;
         END IF;
        END WHILE; 
        RETURN (rel);
       END;