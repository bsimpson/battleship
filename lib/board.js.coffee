class @Board
  @MAX_ROW: 9
  @MAX_COLUMN: 11

  constructor: ->
    @board = @buildBoard()

  buildBoard: ->
    board = []
    for row in [0..Board.MAX_ROW]
      for column in [0..Board.MAX_COLUMN]
        board[row] ||= new Row(row)
        board[row].addColumn(column)
    board
