import { environment } from "../config/environment.config";
export  const chainObj = [{
    chainId: environment.chainid,
    chainName: environment.chainname,
    rpc: environment.rpc,
    rest: environment.rest,
    bip44: {
        coinType: environment.bip44cointype,
    },
    bech32Config: {
        bech32PrefixAccAddr: environment.bech32prefixaccaddr,
        bech32PrefixAccPub: environment.bech32prefixaccpub,
        bech32PrefixValAddr: environment.bech32prefixvaladdr,
        bech32PrefixValPub: environment.bech32prefixvalpub,
        bech32PrefixConsAddr: environment.bech32prefixconsaddr,
        bech32PrefixConsPub: environment.bech32prefixconspub,
    },
    currencies: [
        {
            coinDenom: 'BEDROCK',
            coinMinimalDenom: 'ubedrock',
            coinDecimals: 6,
            coinGeckoId: 'bedock',
        },
        {
            coinDenom: 'PYLON',
            coinMinimalDenom: 'upylon',
            coinDecimals: 6,
            coinGeckoId: 'pylon',
        },
        {
            coinDenom: 'USD',
            coinMinimalDenom: 'ustripeusd',
            coinDecimals: 6,
            coinGeckoId: 'usd',
        }
  
    ],
    feeCurrencies: [
        {
            coinDenom: environment.feecurrenciescoindenom,
            coinMinimalDenom: environment.feecurrenciescoinminimaldenom,
            coinDecimals: environment.feecurrenciescoindecimals,
            coinGeckoId: environment.feecurrenciescoingeckoid,
            gasPriceStep: {
                low: environment.gaspricesteplow,
                medium: environment.gaspricestepmedium,
                high: environment.gaspricestephigh,
                average: environment.gaspricestepaverage,
            },
        },
    ],
    stakeCurrency: {
        coinDenom: environment.stakecurrencycoindenom,
        coinMinimalDenom: environment.stakecurrencycoinminimaldenom,
        coinDecimals: environment.stakecurrencycoindecimals,
        coinGeckoId: environment.stakecurrencycoingeckoid,
    },
    gasPriceStep: {
        low: environment.gaspricesteplow,
        medium: environment.gaspricestepmedium,
        high: environment.gaspricestephigh,
    },
}]