@Turns = new Meteor.Collection 'turns',
  transform: (doc) ->
    new Turn(doc)

Turns.validForPlayer = (player) ->
  lastTurn = @findOne({}, { sort: { createdAt: -1 } })
  if lastTurn
    lastTurn.player != player
  else
    player == 'player1'
