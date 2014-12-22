-- ------------------------------------------------------------------------------------
-- Example SQL script to idempotently add a new column to an existing table.
-- ------------------------------------------------------------------------------------

delimiter '//'

DROP PROCEDURE IF EXISTS alter_mytable_add_column1;

CREATE PROCEDURE alter_mytable_add_column1() BEGIN
    IF NOT EXISTS (
        SELECT * FROM information_schema.COLUMNS
        WHERE COLUMN_NAME='column1'
        AND TABLE_NAME='mytable'
        AND TABLE_SCHEMA=(SELECT DATABASE())
        )
    THEN

        -- 'Echo' a message to show that we are applying this change
        SELECT "Adding column 'column1' to 'mytable'" AS ' ';
        
        -- Apply alter table
        ALTER TABLE mytable
        ADD `column1` CHAR(32) DEFAULT NULL;

    END IF;
END;
//

delimiter ';'

CALL alter_mytable_add_column1();

DROP PROCEDURE alter_mytable_add_column1;


