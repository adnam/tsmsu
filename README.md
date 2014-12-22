# tsmsu

**Totally simple MySQL schema upgrades**

*AKA: "totally stupid MySQL schema upgrades"*

*AKA: it's time to get your database migration scripts in order*

## How it works

Drop your SQL schema changes into the `migrations` directory. In order to 
execute them in sequential order, name them like this:-

    migrations/
    ├── 0.1_initial_structure.sql
    ├── 0.2_alter_foo_add_column_bar.sql
    ├── 0.3_add_index_to_col1.sql
    └── 1.0_new_version.sql

The migration scripts should be idempotent, so running them multiple times
will only change the database once. Look at the examples in the `templates`
directory.

To upgrate your database just run this script to apply the changes in order:

    $ ./tsmsu -D db_name -u user -p passwd

The purpose of this project is not to provide anything like full-fledged
migrations, such as django south, or alembic. It's simply a way to get
your SQL `ALTER TABLE` scripts organised. You should be able to upgrade
your schema with a single command, which is run as a post-commit hook
or Jenkins build script.

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
    Running migration script 'templates/40-add-index.sql'
        Adding index to mytable.column1
    Done.

Told you it was stupid.

