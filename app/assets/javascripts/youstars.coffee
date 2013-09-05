#= require angular
#= require angular-cookies

youstars = angular.module 'youstars', ['ngCookies']


youstars.factory 'User', ($window,$http,$cookies) ->
  is_oauthed: ->
    $cookies.ytauth?
  yt_auth: JSON.parse($cookies.ytauth)
  token: ->
    @yt_auth.access_token
    
youstars.factory 'Channels', ($window,$http,$cookies, User) ->
  subscribers: ->
    console.log "subscribers:", User.yt_auth
    req = $http.get "https://www.googleapis.com/youtube/v3/subscriptions?part=id%2Csnippet%2CcontentDetails&mine=true&key=AIzaSyAYzl7L1LA8RKF8-zwx_10yNF-vplq-XwY",
      headers: {'Authorization': "Bearer #{User.token()}"}

    req.then (res) ->
      res.data

youstars.controller 'IndexController', ($scope, $window, Channels, $cookies) ->
  console.log Channels.subscribers()
  console.log '----cookies yo----'
  console.log $cookies.ytauth
  console.log JSON.parse($cookies.ytauth)
