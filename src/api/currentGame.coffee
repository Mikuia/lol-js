ld      = require 'lodash'
{promiseToCb} = require '../utils'

api = exports.api = {
    fullname: "current-game-v1.0",
    name: "current-game",
    version: "v1.0"
}

platforms = {
    "br": "BR1",
    "eune": "EUN1",
    "euw": "EUW1",
    "kr": "KR",
    "lan": "LA1",
    "las": "LA2",
    "na": "NA1",
    "oce": "OC1",
    "pbe": "PBE1",
    "ru": "RU",
    "tr": "TR1"
}

exports.methods = {
    getSpectatorGameInfoAsync: (summonerId, options={}) ->
        options = ld.defaults {}, options, {
            region: @defaultRegion
            platformId: 'EUW1'
        }
        region = options.region ? @defaultRegion

        requestParams = {
            caller: "getSpectatorGameInfo",
            region: region,
            url: "https://#{region}.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/#{platforms[region]}/#{summonerId}"
            queryParams: {season: options.season}
        }

        cacheParams = {
            key: "#{api.fullname}-match-#{region}-#{summonerId}"
            region, api,
            ttl: @cacheTTL.long
            objectType: 'current-game'
            params: {summonerId}
        }

        @_riotRequestWithCache requestParams, cacheParams
}
