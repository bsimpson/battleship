class @Cell
  constructor: (doc) ->
    _.extend(@, doc)

  position: ->
    JSON.stringify
      row: @row
      column: @column

  selected: ->
    !!Cells.findOne
      row: @row
      column: @column
      player: Session.get('player')

  hit: ->
    otherPlayer = if (Session.get('player') == 'player1') then 'player2' else 'player1'
    guessed = Turns.guessed @row, @column, Session.get('player')
    return false unless guessed # If they haven't guessed, we don't want to report

    !!Cells.findOne
      row: @row
      column: @column
      player: otherPlayer

  guesses: ->
    guesses = []
    if Turns.guessed @row, @column, 'player1'
      guesses.push 'player1'
    if Turns.guessed @row, @column, 'player2'
      guesses.push 'player2'
    if guesses.length > 1
      'both'
    else
      guesses[0]
