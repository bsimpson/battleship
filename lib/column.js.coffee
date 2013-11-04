class @Column
  constructor: (column, row) ->
    @column = column
    @row = row

  position: ->
    JSON.stringify
      row: @row
      column: @column

  selected: ->
    !!Cells.findOne
      row: @row
      column: @column
