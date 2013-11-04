@board = new Board()

if Meteor.isClient
  Template.board.rows = board.board
  Template.column.events
    "click .cell": (evt) =>
      position = $(evt.target).data('position')
      alert @Cells.isHit position


if Meteor.isServer
  Meteor.startup ->
    @Cells.seedShips()
