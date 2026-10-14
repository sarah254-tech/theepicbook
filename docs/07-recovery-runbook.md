# EpicBook Recovery Runbook

## 1. Check Service Health

Run `docker compose ps` to inspect the database, backend, and reverse proxy. Check the public health endpoint using `curl http://localhost/health`.

## 2. Restart a Failed Service

Restart only the affected service:

- Backend: `docker compose restart backend`
- Database: `docker compose restart database`
- Reverse proxy: `docker compose restart reverse-proxy`

Verify service health after restarting. If the issue persists, inspect logs using `docker compose logs --tail=100 SERVICE_NAME`.

## 3. Database Backup

Create a database backup before making destructive changes. Store it in a protected location and verify the backup completion marker. Keep an additional copy outside the VM for disaster recovery.

## 4. Database Restore

Test restoration in a separate database before overwriting live data. Confirm the restored tables and record counts before using the backup for production recovery.

## 5. Persistent Storage

The database uses the named volume `db_data`. Never run `docker compose down -v` during routine maintenance because it can remove persistent database storage.

## 6. Secret Rotation

Update database credentials securely in the environment configuration, coordinate the changes with MySQL and the application, recreate the affected services, and verify database connectivity. Never put secrets in logs, screenshots, or source control.

## 7. Verification

After recovery, verify all three services are healthy, the public health endpoint reports a connected database, the website loads successfully, and the database records remain intact.
