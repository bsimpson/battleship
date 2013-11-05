@Guesses = new Meteor.Collection 'guesses'

@Guesses.record = (position, player) ->
  @insert
    row: position.row
    column: position.column
    player: player

@Guesses.guessed = (row, column, player) ->
  !!@findOne
      row: row
      column: column
      player: player
