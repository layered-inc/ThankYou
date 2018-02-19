App.message = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    console.log "connected"
# Called when the subscription is ready for use on the server

  disconnected: ->
    console.log "disconnected"
# Called when the subscription has been terminated by the server

  received: (data) ->
    $(data["message"]).prependTo("#messages").hide().fadeIn()
