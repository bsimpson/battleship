@Players = new Meteor.Collection 'players',
  transform: (doc) ->
    new Player(doc)

@Players.select = (player) ->
  @insert
    player: player

@Players.unselect = (player) ->
  @remove
    player: player

@Players.chosen = (player) ->
  @findOne
    player: player
