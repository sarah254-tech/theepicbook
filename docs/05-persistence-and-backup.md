# EpicBook Database Persistence and Backup

## Persistent Storage

The MySQL database stores its data in the named Docker volume `db_data`, mounted at `/var/lib/mysql`. This allows database files to persist when the database container is recreated.

## Backup Procedure

A SQL backup was created at `backups/epicbook-backup.sql` using `mysqldump` with the `--no-tablespaces` option.

The backup was checked for SQL statements and a completion marker.

## Restore Verification

The backup was restored into a separate test database named `epicbook_restore_test`. This approach avoids overwriting the live `bookstore` database during the test.

The restored database was checked by counting the authors and books and comparing the results with the original database.

## Recovery Safety

- Back up the database before making destructive changes.
- Verify that the backup file exists and is complete.
- Test restoration in a separate database before restoring production data.
- Do not use `docker compose down -v` during routine restarts because it can delete persistent volumes.
- Restrict access to backup files because they contain application data.
- Store an additional backup securely outside the VM for disaster recovery.
