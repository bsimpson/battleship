class @Row
  constructor: (row) ->
    @row = row
    @columns = []

  addColumn: (column) ->
    column = new Column(column, @row)
    @columns.push(column)
