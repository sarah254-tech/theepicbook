
# EpicBook Environment Variables and Ports

## Environment Variables

The application uses a local `.env` file for configuration. The file contains secrets and must not be committed to Git.

| Variable | Purpose |
|---|---|
| MYSQL_DATABASE | MySQL database name |
| MYSQL_USER | Application database user |
| MYSQL_PASSWORD | Application database password |
| MYSQL_ROOT_PASSWORD | MySQL root password |
| DB_HOST | Database service hostname in Docker Compose |
| DB_PORT | MySQL internal port |
| DB_NAME | Database used by the application |
| DB_USER | Application database username |
| DB_PASSWORD | Application database password |

## Port Configuration

| Component | Container Port | Published Host Port |
|---|---:|---|
| Nginx reverse proxy | 80 | 80 |
| Node.js/Express backend | 8080 | Not published |
| MySQL database | 3306 | Not published |

## Security Practices

- Store credentials in `.env`, not in source code.
- Ensure `.env` is excluded from Git.
- Restrict public application access to the reverse proxy.
- Keep backend and database ports private.
- Restrict SSH access to trusted source IP addresses.
- Never include credentials in screenshots or logs.

