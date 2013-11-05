class @Row
  constructor: (row) ->
    @row = row
    @cells = []

  addColumn: (column) ->
    cell = new Cell
      column: column
      row: @row
    @cells.push(cell)
