timeTracker.provider("State", (LogProvider) ->

  state =
    debug:          false
    logLevel:       LogProvider.Level.WARN
    isTracking:     false
    isAdding:       false
    isSaving:       false
    isLoadingIssue: false

  return {
    State: state
    $get: () -> return state
  }

)

