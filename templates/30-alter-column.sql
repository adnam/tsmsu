-- ------------------------------------------------------------------------------------
-- Example SQL script to alter a column
-- ------------------------------------------------------------------------------------

delimiter '//'

-- Rename the procedure to something more desctiptive.
DROP PROCEDURE IF EXISTS alter_column_mytable_column1;

CREATE PROCEDURE alter_column_mytable_column1() BEGIN

    -- If the table is not currently a VARCHAR, change it to one
    IF NOT EXISTS(
        SELECT * FROM information_schema.COLUMNS
        WHERE TABLE_NAME='mytable'
        AND TABLE_SCHEMA = (SELECT DATABASE())
        AND COLUMN_NAME="column1" AND DATA_TYPE LIKE "VARCHAR"
        )
    THEN
        -- Info message
        SELECT "Changing `mytable`.`column1` to VARCHAR" AS ' ';
        
        -- ALTER statement
        ALTER TABLE `mytable` MODIFY `column1` VARCHAR(40);
    END IF;

END;
//

delimiter ';'

CALL alter_column_mytable_column1();

DROP PROCEDURE alter_column_mytable_column1;


