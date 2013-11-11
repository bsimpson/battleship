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
      if Turns.validForPlayer(Session.get("player"))
        position = $(evt.target).data('position')
        Guesses.record(position, Session.get("player"))
        Turns.insert
          player: Session.get('player')
          createdAt: new Date()
        if Turns.victoryForPlayer1()
          alert 'Player 1 is victorious!'
        else if Turns.victoryForPlayer2()
          alert 'Player 2 is victorious!'
        else
          hit = Cells.isHit(position, Session.get('player'))
          alert(if hit then 'Its a hit!' else 'You missed...')
      else
        alert 'Its not your turn'

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
    Turns.remove {}
    Cells.seedShips(@player1.player)
    Cells.seedShips(@player2.player)

