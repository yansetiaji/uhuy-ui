FROM oven/bun:1.1.24-alpine AS base
WORKDIR /usr/src/app

FROM base as build
COPY . .
RUN bun run build

FROM base
COPY --from=build /usr/src/app/.output /usr/src/app/.output
ENTRYPOINT [ "bun", ".output/server/index.mjs" ]