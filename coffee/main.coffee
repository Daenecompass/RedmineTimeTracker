@timeTracker = angular.module('timeTracker', ['ngResource', 'timer'])

timeTracker.factory("$message", ['$rootScope', '$timeout', ($rootScope, $timeout) ->

  MESSAGE_DURATION = 1000

  return {

    ###
     show message page bottom.
    ###
    toast: (msg, duration) ->
      duration = duration or MESSAGE_DURATION
      $rootScope.messages.push msg
      $timeout ->
        $rootScope.messages.shift()
      , duration
  }
])

timeTracker.controller('MainCtrl', ['$rootScope', '$scope', '$ticket', ($rootScope, $scope, $ticket) ->

  TICKET_SYNC = "TICKET_SYNC"
  MINUTE_5 = 5

  $rootScope.messages = []

  $ticket.load (tickets) ->
    $ticket.set tickets

  alarmInfo =
    when: Date.now() + 1
    periodInMinutes: MINUTE_5

  chrome.alarms.create(TICKET_SYNC, alarmInfo)
  chrome.alarms.onAlarm.addListener (alarm) ->
    if alarm.name is TICKET_SYNC
      $ticket.sync()

])
