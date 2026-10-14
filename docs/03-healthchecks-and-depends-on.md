# EpicBook Health Checks and Service Dependencies

## Health Checks

EpicBook uses Docker Compose health checks to monitor service readiness.

- **Database:** MySQL is checked using `mysqladmin ping`.
- **Backend:** An HTTP request checks the `/health` endpoint on port 8080. A successful response confirms that the backend can connect to MySQL.
- **Reverse proxy:** Nginx checks the `/health` endpoint through its own HTTP listener.

## Service Dependencies

The backend depends on the database with `condition: service_healthy`. This delays backend startup until the database passes its health check.

The reverse proxy depends on the backend with `condition: service_healthy`. This helps ensure the backend is ready before the proxy starts.

## Verification Results

The following checks have been performed:

- Backend health endpoint returned HTTP 200.
- Health response reported `status: healthy` and `database: connected`.
- Public health endpoint responded successfully.
- All three services were reported healthy in Docker Compose.

## Limitations

Health checks indicate service availability at the time of testing. They do not guarantee that every application feature is working correctly. Application routes and database operations require separate tests.
