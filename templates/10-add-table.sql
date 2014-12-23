-- ------------------------------------------------------------------------------------
-- Example SQL script to add a new table to a schema
-- 
-- The table is only created if previously it does not exist.
-- ------------------------------------------------------------------------------------

delimiter '//'

-- Rename the procedure to something more desctiptive.
DROP PROCEDURE IF EXISTS add_table_mytable;

CREATE PROCEDURE add_table_mytable() BEGIN
    
    -- Use an IF-THEN-ELSE block to execute the 'CREATE TABLE' only if
    -- it does not already exist.
    IF NOT EXISTS(
        SELECT * FROM information_schema.TABLES
        WHERE TABLE_NAME='mytable'
        AND TABLE_SCHEMA=(SELECT DATABASE())
        )
    THEN
        
        -- Info message
        SELECT "Creating table 'mytable'" AS ' ';

        -- Normal 'CREATE TABLE' statement goes here
        CREATE TABLE `mytable` (
           `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
           `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            KEY `idx_mytable_created` (`created`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

    END IF;

END;
//

delimiter ';'

CALL add_table_mytable();

DROP PROCEDURE add_table_mytable;


