-- ------------------------------------------------------------------------------------
-- Example SQL script to indempotently add an index to a column
-- ------------------------------------------------------------------------------------

delimiter '//'

DROP PROCEDURE IF EXISTS add_column_index;

CREATE PROCEDURE add_column_index() BEGIN
    
    -- Look in information_schema.STATISTICS for the index
    IF NOT EXISTS(
        SELECT * FROM information_schema.STATISTICS
        WHERE TABLE_SCHEMA = (SELECT DATABASE())
        AND TABLE_NAME = "mytable"
        AND INDEX_NAME = "idx_mytable_column1"
        AND COLUMN_NAME = "column1"
        )
    THEN
        -- Info message
        SELECT "Adding index to mytable.column1" AS ' ';
        
        -- ALTER statement
        ALTER TABLE mytable ADD KEY `idx_mytable_column1` (`column1`);
    END IF;

END;
//

delimiter ';'

CALL add_column_index();

DROP PROCEDURE add_column_index;



