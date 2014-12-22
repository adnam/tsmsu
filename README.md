# tsmsu

totally simple MySQL schema upgrades

(aka "totally stupid MySQL schema upgrades")


## How it works

Drop your SQL schema changes into the `migrations` directory. In order to 
execute them in sequential order, name them like this:-

    migrations/
    ├── 10_initial_structure.sql
    ├── 20_alter_foo_add_column_bar.sql
    ├── 30_add_index_to_col1.sql
    └── 100_new_version.sql

The migration script should be idempotent, as such running them multiple times
will only change the database once. Look at the examples in the `templates`
directory.

To upgrate your database just run this script to apply the changes in order:

    $./tsmsu -D db_name -u user -p passwd

## Usage

    usage: ./tsmsu -D database -u user -p password

    Apply sequential idempotent upgrade scripts to a mysql database.

    REQUIRED OPTIONS:
        -D name of database to apply upgrade
        -u mysql username
        -p mysql password
    OTHER OPTIONS:
        -m directory containing the migration scripts
        -h hostname, default localhost
        -P port TCP/IP port number to use for the mysql connection

## Sample output

    $ ./tsmsu -D example_tsmsu -u mysql_user -p mypasswd -m templates
    Running migration script 'templates/10-add-table.sql'
    Creating table 'mytable'
    Running migration script 'templates/20-add-column.sql'
    Adding column 'column1' to 'mytable'
    Running migration script 'templates/30-alter-column.sql'
    Changing `mytable`.`column1` to VARCHAR
    Done.

Told you it was stupid.

