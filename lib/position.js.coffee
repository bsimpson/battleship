class @Position
  constructor: (options) ->
    @row = options.row
    @column = options.column

  toComparable: ->
    JSON.stringify
      row: @row
      column: @column
