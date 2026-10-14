# Stage 1: Install production dependencies
FROM node:20-bookworm-slim AS dependencies

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --omit=dev \
    && npm cache clean --force

# Stage 2: Minimal production runtime
FROM node:20-bookworm-slim AS runtime

ENV NODE_ENV=production
ENV PORT=8080

WORKDIR /app

COPY --from=dependencies --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node package.json server.js ./
COPY --chown=node:node config ./config
COPY --chown=node:node models ./models
COPY --chown=node:node routes ./routes
COPY --chown=node:node views ./views
COPY --chown=node:node public ./public

USER node

EXPOSE 8080

CMD ["node", "server.js"]
