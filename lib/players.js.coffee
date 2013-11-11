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

@Players.otherPlayer = (player) ->
  if player == 'player1' then 'player2' else 'player1'
