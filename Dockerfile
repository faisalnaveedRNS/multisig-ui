# Install dependencies only when needed
FROM node:16-alpine AS deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json ./
RUN npm i  --legacy-peer-deps


# Rebuild the source code only when needed
FROM node:16-alpine AS builder
ENV GENERATE_SOURCEMAP false

WORKDIR /app

ARG  NEXT_PUBLIC_HOST
ARG  NEXT_PUBLIC_CHAIN_ID 
ARG  NEXT_PUBLIC_CHAIN_NAME 
ARG  NEXT_PUBLIC_RPC
ARG  NEXT_PUBLIC_REST
ARG  NEXT_PUBLIC_BIP44_COINTYPE
ARG  NEXT_PUBLIC_BECH32_PREFIX_ACC_ADDR 
ARG  NEXT_PUBLIC_BECH32_PREFIX_ACC_PUB 
ARG  NEXT_PUBLIC_BECH32_PREFIX_VAL_ADDR 
ARG  NEXT_PUBLIC_BECH32_PREFIX_VAL_PUB 
ARG  NEXT_PUBLIC_BECH32_PREFIX_CONS_ADDR 
ARG  NEXT_PUBLIC_BECH32_PREFIX_CONS_PUB 
ARG  NEXT_PUBLIC_CURRENCIES_COIN_DENOM 
ARG  NEXT_PUBLIC_CURRENCIES_COIN_MINIMAL_DENOM 
ARG  NEXT_PUBLIC_CURRENCIES_COIN_DECIMALS 
ARG  NEXT_PUBLIC_CURRENCIES_COIN_GECKO_ID 
ARG  NEXT_PUBLIC_FEE_CURRENCIES_COIN_DENOM 
ARG  NEXT_PUBLIC_FEE_CURRENCIES_COIN_MINIMAL_DENOM 
ARG  NEXT_PUBLIC_FEE_CURRENCIES_COIN_DECIMALS
ARG  NEXT_PUBLIC_FEE_CURRENCIES_COIN_GECKO_ID 
ARG  NEXT_PUBLIC_STAKE_CURRENCY_COIN_DENOM 
ARG  NEXT_PUBLIC_STAKE_CURRENCY_COIN_MINIMAL_DENOM 
ARG  NEXT_PUBLIC_STAKE_CURRENCY_COIN_DECIMALS
ARG  NEXT_PUBLIC_STAKE_CURRENCY_COIN_GECKO_ID 
ARG  NEXT_PUBLIC_GAS_PRICE_STEP_LOW
ARG  NEXT_PUBLIC_GAS_PRICE_STEP_MEDIUM
ARG  NEXT_PUBLIC_GAS_PRICE_STEP_HIGH
ARG  NEXT_PUBLIC_GAS_PRICE_STEP_AVERAGE
ARG  NEXT_PUBLIC_DENOM 
ARG  NEXT_PUBLIC_DISPLAY_DENOM 
ARG  NEXT_PUBLIC_BASE_DENOM 
ARG  NEXT_PUBLIC_BASE_EXPONENT
ARG  NEXT_PUBLIC_NAME 
ARG  NEXT_PUBLIC_PREFIX 
ARG  NEXT_PUBLIC_COLOR 
ARG  NEXT_PUBLIC_EXPLORER 
ARG  NEXT_PUBLIC_TX_EXPLORER 
ARG  NEXT_PUBLIC_VAL_EXPLORER 
ARG  NEXT_PUBLIC_GOV_EXPLORER 
ARG  NEXT_PUBLIC_LOGO 
ARG  NEXT_PUBLIC_HYPERLINK

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry during the build.
# ENV NEXT_TELEMETRY_DISABLED 1

ENV  NEXT_PUBLIC_HOST ${NEXT_PUBLIC_HOST} 
ENV  NEXT_PUBLIC_CHAIN_ID  ${NEXT_PUBLIC_CHAIN_ID} 
ENV  NEXT_PUBLIC_CHAIN_NAME  ${NEXT_PUBLIC_CHAIN_NAME} 
ENV  NEXT_PUBLIC_RPC  ${NEXT_PUBLIC_RPC} 
ENV  NEXT_PUBLIC_REST  ${NEXT_PUBLIC_REST} 
ENV  NEXT_PUBLIC_BIP44_COINTYPE  ${NEXT_PUBLIC_BIP44_COINTYPE} 
ENV  NEXT_PUBLIC_BECH32_PREFIX_ACC_ADDR  ${NEXT_PUBLIC_BECH32_PREFIX_ACC_ADDR} 
ENV  NEXT_PUBLIC_BECH32_PREFIX_ACC_PUB  ${NEXT_PUBLIC_BECH32_PREFIX_ACC_PUB} 
ENV  NEXT_PUBLIC_BECH32_PREFIX_VAL_ADDR  ${NEXT_PUBLIC_BECH32_PREFIX_VAL_ADDR} 
ENV  NEXT_PUBLIC_BECH32_PREFIX_VAL_PUB  ${NEXT_PUBLIC_BECH32_PREFIX_VAL_PUB}
ENV  NEXT_PUBLIC_BECH32_PREFIX_CONS_ADDR  ${NEXT_PUBLIC_BECH32_PREFIX_CONS_ADDR} 
ENV  NEXT_PUBLIC_BECH32_PREFIX_CONS_PUB  ${NEXT_PUBLIC_BECH32_PREFIX_CONS_PUB} 
ENV  NEXT_PUBLIC_CURRENCIES_COIN_DENOM  ${NEXT_PUBLIC_CURRENCIES_COIN_DENOM} 
ENV  NEXT_PUBLIC_CURRENCIES_COIN_MINIMAL_DENOM  ${NEXT_PUBLIC_CURRENCIES_COIN_MINIMAL_DENOM} 
ENV  NEXT_PUBLIC_CURRENCIES_COIN_DECIMALS  ${NEXT_PUBLIC_CURRENCIES_COIN_DECIMALS} 
ENV  NEXT_PUBLIC_CURRENCIES_COIN_GECKO_ID  ${NEXT_PUBLIC_CURRENCIES_COIN_GECKO_ID} 
ENV  NEXT_PUBLIC_FEE_CURRENCIES_COIN_DENOM  ${NEXT_PUBLIC_FEE_CURRENCIES_COIN_DENOM} 
ENV  NEXT_PUBLIC_FEE_CURRENCIES_COIN_MINIMAL_DENOM  ${NEXT_PUBLIC_FEE_CURRENCIES_COIN_MINIMAL_DENOM} 
ENV  NEXT_PUBLIC_FEE_CURRENCIES_COIN_DECIMALS  ${NEXT_PUBLIC_FEE_CURRENCIES_COIN_DECIMALS} 
ENV  NEXT_PUBLIC_FEE_CURRENCIES_COIN_GECKO_ID  ${NEXT_PUBLIC_FEE_CURRENCIES_COIN_GECKO_ID} 
ENV  NEXT_PUBLIC_STAKE_CURRENCY_COIN_DENOM  ${NEXT_PUBLIC_STAKE_CURRENCY_COIN_DENOM} 
ENV  NEXT_PUBLIC_STAKE_CURRENCY_COIN_MINIMAL_DENOM  ${NEXT_PUBLIC_STAKE_CURRENCY_COIN_MINIMAL_DENOM} 
ENV  NEXT_PUBLIC_STAKE_CURRENCY_COIN_DECIMALS  ${NEXT_PUBLIC_STAKE_CURRENCY_COIN_DECIMALS} 
ENV  NEXT_PUBLIC_STAKE_CURRENCY_COIN_GECKO_ID  ${NEXT_PUBLIC_STAKE_CURRENCY_COIN_GECKO_ID} 
ENV  NEXT_PUBLIC_GAS_PRICE_STEP_LOW  ${NEXT_PUBLIC_GAS_PRICE_STEP_LOW} 
ENV  NEXT_PUBLIC_GAS_PRICE_STEP_MEDIUM  ${NEXT_PUBLIC_GAS_PRICE_STEP_MEDIUM} 
ENV  NEXT_PUBLIC_GAS_PRICE_STEP_HIGH  ${NEXT_PUBLIC_GAS_PRICE_STEP_HIGH} 
ENV  NEXT_PUBLIC_GAS_PRICE_STEP_AVERAGE  ${NEXT_PUBLIC_GAS_PRICE_STEP_AVERAGE} 
ENV  NEXT_PUBLIC_DENOM  ${NEXT_PUBLIC_DENOM} 
ENV  NEXT_PUBLIC_DISPLAY_DENOM  ${NEXT_PUBLIC_DISPLAY_DENOM} 
ENV  NEXT_PUBLIC_BASE_DENOM  ${NEXT_PUBLIC_BASE_DENOM} 
ENV  NEXT_PUBLIC_BASE_EXPONENT  ${NEXT_PUBLIC_BASE_EXPONENT} 
ENV  NEXT_PUBLIC_NAME  ${NEXT_PUBLIC_NAME} 
ENV  NEXT_PUBLIC_PREFIX  ${NEXT_PUBLIC_PREFIX} 
ENV  NEXT_PUBLIC_COLOR  ${NEXT_PUBLIC_COLOR} 
ENV  NEXT_PUBLIC_EXPLORER  ${NEXT_PUBLIC_EXPLORER} 
ENV  NEXT_PUBLIC_TX_EXPLORER  ${NEXT_PUBLIC_TX_EXPLORER} 
ENV  NEXT_PUBLIC_VAL_EXPLORER  ${NEXT_PUBLIC_VAL_EXPLORER} 
ENV  NEXT_PUBLIC_GOV_EXPLORER  ${NEXT_PUBLIC_GOV_EXPLORER} 
ENV  NEXT_PUBLIC_LOGO  ${NEXT_PUBLIC_LOGO} 
ENV  NEXT_PUBLIC_HYPERLIN ${NEXT_PUBLIC_HYPERLINK}

RUN npm run build

# If using npm comment out above and use below instead
# RUN npm run build

# Production image, copy all the files and run next
FROM node:16-alpine AS runner
WORKDIR /app

ENV NODE_ENV production
# Uncomment the following line in case you want to disable telemetry during runtime.
# ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# You only need to copy next.config.js if you are NOT using the default configuration
COPY --from=builder /app/jest.config.js ./
COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json

# Automatically leverage output traces to reduce image size 
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/ ./.next/

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["npm","start"]
