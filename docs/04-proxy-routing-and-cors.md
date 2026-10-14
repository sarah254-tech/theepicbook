# EpicBook Reverse-Proxy Routing and CORS

## Reverse-Proxy Routing

Nginx is the public entry point for EpicBook and listens on TCP port 80.

- `/health` forwards health checks to the Node.js backend.
- `/api/` forwards API requests to the backend.
- `/` forwards website page requests to the backend.

The proxy forwards request headers such as `Host`, `X-Real-IP`, `X-Forwarded-For`, and `X-Forwarded-Proto`.

Only Nginx publishes a host port. The backend listens internally on port 8080, and MySQL uses port 3306 within the Docker network.

## CORS Considerations

Cross-Origin Resource Sharing (CORS) controls whether a browser can make requests between different origins.

EpicBook currently serves its pages and API through the same public origin. Therefore, a separate cross-origin configuration is not required for the normal same-origin browser workflow.

If a separate frontend is introduced later, configure the backend to allow only the specific trusted frontend origin rather than allowing every origin by default.

## Verification

The following routes were tested through the Nginx reverse proxy:

- Home page: HTTP 200
- Gallery page: HTTP 200
- Cart page: HTTP 200
- Cart API: HTTP 200

The public health endpoint also returned a healthy status with a connected database.
