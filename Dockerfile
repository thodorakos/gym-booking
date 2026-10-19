# syntax=docker/dockerfile:1.7

FROM node:22-alpine AS deps
WORKDIR /app
ENV npm_config_audit=false npm_config_fund=false npm_config_update_notifier=false

COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm,sharing=locked npm ci --prefer-offline --no-progress

FROM node:22-alpine AS build
WORKDIR /app
ENV npm_config_audit=false npm_config_fund=false npm_config_update_notifier=false

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build && npm prune --omit=dev

FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=4321

COPY --from=build --chown=node:node /app/dist ./dist
COPY --from=build --chown=node:node /app/node_modules ./node_modules
COPY --from=build --chown=node:node /app/package.json ./package.json

USER node
EXPOSE 4321
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 CMD node -e "fetch('http://127.0.0.1:4321').then((r)=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"

CMD ["node", "./dist/server/entry.mjs"]
