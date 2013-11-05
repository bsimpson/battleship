class @Player
  constructor: (doc) ->
    _.extend(@, doc)

  chosen: (player) ->
    !!Players.chosen @player
