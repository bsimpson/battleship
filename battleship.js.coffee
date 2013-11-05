@board = new Board()
@player1 = new Player player: 'player1'
@player2 = new Player player: 'player2'

if Meteor.isClient
  Meteor.startup ->
    Session.set('player', null)

  Template.board.rows = ->
    board.board

  Template.players.player1 = ->
    new Player(player: 'player1')

  Template.players.player2 = ->
    new Player(player: 'player2')

  Template.cell.events
    "click .cell": (evt) =>
      position = $(evt.target).data('position')
      Guesses.record(position, Session.get("player"))
      hit = Cells.isHit(position, Session.get('player'))
      alert(if hit then 'Its a hit!' else 'You missed...')

  Template.players.events
    "click .player": (evt) =>
      target = $(evt.target)
      player = Players.select target.val()
      Session.set "player", target.val()

if Meteor.isServer
  Meteor.startup ->
    Players.remove {}
    Guesses.remove {}
    Cells.remove {}
    Cells.seedShips(@player1.player)
    Cells.seedShips(@player2.player)

