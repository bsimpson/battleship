@Turns = new Meteor.Collection 'turns',
  transform: (doc) ->
    new Turn(doc)

@Turns.validForPlayer = (player) ->
  lastTurn = @findOne({}, { sort: { createdAt: -1 } })
  if lastTurn
    lastTurn.player != player
  else
    player == 'player1'

@Turns.victoryForPlayer1 = ->
  return @victoryForPlayer('player1')

@Turns.victoryForPlayer2 = ->
  return @victoryForPlayer('player2')

@Turns.victoryForPlayer = (player) ->
  otherPlayerShips = Cells.find(player: Players.otherPlayer(player)).fetch()
  playerGuesses = Guesses.find(player: player).fetch()

  shipPositions = _(otherPlayerShips).map (ship) ->
    new Position(ship).toComparable()

  playerGuessPositions = _(playerGuesses).map (guess) ->
    new Position(guess).toComparable()

  _(shipPositions).difference(playerGuessPositions).length == 0
