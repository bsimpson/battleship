@Cells = new Meteor.Collection 'cells',
  transform: (doc) ->
    new Cell(doc)

@Cells.isHit = (position, player) ->
  otherPlayer = if (player == 'player1') then 'player2' else 'player1'
  !!@findOne
    row: position.row
    column: position.column
    player: otherPlayer

@Cells.seedShips = (player) ->
  ships = [
    { name: 'aircraftCarrier', length: 5 },
    { name: 'battleship',      length: 4 },
    { name: 'submarine',       length: 3 },
    { name: 'destroyer',       length: 3 },
    { name: 'patrolBoat',      length: 2 }
  ]

  @insertShip(ship, player) for ship in ships

@Cells.insertShip = (ship, player) ->
  position = @randomStartPosition(ship, player)
  x = 0
  while x < ship.length
    if position.orientation == 'down'
      @insert
        row: position.row + x
        column: position.column
        ship: ship.name
        player: player
    else
      @insert
        row: position.row
        column: position.column + x
        ship: ship.name
        player: player
    x++

@Cells.randomStartPosition = (ship, player) ->
  orientation = @orientation()
  if orientation == 'down'
    startRow = @getRandomInt(0, (Board.MAX_ROW - ship.length))
    startColumn = @getRandomInt(0, Board.MAX_COLUMN)
  else
    startRow = @getRandomInt(0, Board.MAX_ROW)
    startColumn = @getRandomInt(0, (Board.MAX_COLUMN - ship.length))

  position = { row: startRow, column: startColumn, orientation: orientation }
  if @overlapping(position, ship, player)
    @randomStartPosition(ship)
  else
    position

@Cells.getRandomInt = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min

@Cells.overlapping = (position, ship, player) ->
  if position.orientation == 'down'
    neededRows = [position.row..(position.row + ship.length)]
    neededColumns = [position.column]
  else
    neededRows = [position.row]
    neededColumns = [position.column..(position.column + ship.length)]

  !!@findOne
    row: $in: neededRows
    column: $in: neededColumns
    player: player

@Cells.orientation = ->
  if (@getRandomInt(0, 1) == 0) then 'across' else 'down'
