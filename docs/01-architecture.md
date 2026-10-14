
# EpicBook Docker Compose Architecture

```text
                    Public Internet
                           |
                    User's Browser
                           |
                 Azure VM: Public IP
                      TCP Port 80
                           |
                  +------------------+
                  | Nginx Reverse    |
                  | Proxy            |
                  +------------------+
                           |
                     front-tier
                           |
                  +------------------+
                  | Node.js / Express|
                  | Backend          |
                  | Container Port   |
                  | 8080              |
                  +------------------+
                           |
                      back-tier
                           |
                  +------------------+
                  | MySQL Database   |
                  | Container Port   |
                  | 3306              |
                  +------------------+
                           |
                    +---------------+
                    | db_data        |
                    | Persistent     |
                    | Docker Volume  |
                    +---------------+

Networks:
- front-tier: reverse proxy connectivity
- back-tier: reverse proxy, backend, and database connectivity

Published host port:
- TCP 80: Nginx reverse proxy only

Internal container ports:
- Backend: 8080
- Database: 3306
```

## Traffic flow

1. The browser connects to the Azure VM through public TCP port 80.
2. Nginx receives the request and forwards it to the Node.js/Express backend.
3. The backend serves the Handlebars pages and communicates with MySQL.
4. MySQL stores application data in the persistent `db_data` volume.
5. The backend and database ports are not published directly to the host.
