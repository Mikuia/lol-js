ld      = require 'lodash'
{promiseToCb} = require '../utils'

api = exports.api = {
    fullname: "stats-v1.3",
    name: "stats",
    version: "v1.3"
}

exports.methods = {
    getRankedStatsForSummonerAsync: (summonerId, options={}) ->
        options = ld.defaults {}, options, {
            region: @defaultRegion
            season: 'SEASON2015'
        }
        region = options.region ? @defaultRegion

        requestParams = {
            caller: "getRankedStatsForSummoner",
            region: region,
            url: "#{@_makeUrl region, api}/by-summoner/#{summonerId}/ranked"
            queryParams: {season: options.season}
        }

        cacheParams = {
            key: "#{api.fullname}-stats-#{region}-#{summonerId}-#{options.season}"
            region, api,
            ttl: @cacheTTL.long
            objectType: 'stats'
            params: {summonerId, season: options.season}
        }

        @_riotRequestWithCache requestParams, cacheParams
}
