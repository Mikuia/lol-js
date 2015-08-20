ld      = require 'lodash'
{promiseToCb} = require '../utils'

api = exports.api = {
    fullname: "league-v2.5",
    name: "league",
    version: "v2.5"
}

exports.methods = {
    getLeaguesBySummonerAsync: (summonerId, options={}) ->
        region = options.region ? @defaultRegion

        requestParams = {
            caller: "getLeagueBySummoner",
            region: region,
            url: "#{@_makeUrl region, api}/by-summoner/#{summonerId}"
            queryParams: {}
        }

        cacheParams = {
            key: "#{api.fullname}-league-#{region}-#{summonerId}"
            region, api,
            ttl: @cacheTTL.long
            objectType: 'league'
            params: {summonerId}
        }

        @_riotRequestWithCache requestParams, cacheParams
}
