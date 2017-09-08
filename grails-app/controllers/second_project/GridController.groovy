package second_project

import grails.converters.JSON

class GridController {

    def gridService
    def cellService

    def index() {
        def gridList = gridService.list()
        respond gridList, model: [gridList: gridList]
    }

    def create(GridCommand gridCommand) {
        gridCommand.clearErrors()
        [gridCommand: gridCommand]
    }

    def save(GridCommand gridCommand) {
        def grid = gridService.save(gridCommand)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'grid.label', default: 'Grid'), grid.id])
                redirect grid
            }
            '*' { respond grid, [status: CREATED] }
        }
    }

    def show(Grid grid) {
        def cellList = grid.getCells()

        [grid: grid, cellList: cellList]
    }

//    https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
    def evolute(Grid grid) {
        grid.gridGeneration += 1

        def cellList = grid.getCells()

        def simpleGrid = new int[grid.x][grid.y]
        def deleteGrid = new int[grid.x][grid.y]
        def createGrid = new int[grid.x][grid.y]

        def createCells = false;
        def deleteCells = false;

        cellList.each { cell ->
            simpleGrid[cell.x - 1][cell.y - 1] = 1
        }

        for (def x = 0; x < grid.x; x++) {
            for (def y = 0; y < grid.y; y++) {

                def numberofNeigbours = 0

                // infinite space
                def xMinusOne = x - 1;
                def yMinusOne = y - 1;

                def xPlusOne = x + 1
                def yPlusOne = y + 1

                if (xMinusOne == -1) {
                    xMinusOne = grid.x - 1
                }
                if (yMinusOne == -1) {
                    yMinusOne = grid.y - 1
                }
                if (xPlusOne == grid.x) {
                    xPlusOne = 0;
                }
                if (yPlusOne == grid.y) {
                    yPlusOne = 0;
                }

                //calculate the number of neighbours
                numberofNeigbours += simpleGrid[xMinusOne][yMinusOne]
                numberofNeigbours += simpleGrid[x][yMinusOne]
                numberofNeigbours += simpleGrid[xPlusOne][yMinusOne]

                numberofNeigbours += simpleGrid[xMinusOne][y]
                numberofNeigbours += simpleGrid[xPlusOne][y]

                numberofNeigbours += simpleGrid[xMinusOne][yPlusOne]
                numberofNeigbours += simpleGrid[x][yPlusOne]
                numberofNeigbours += simpleGrid[xPlusOne][yPlusOne]

                //game of life algorithm
                if (simpleGrid[x][y] == 1) {
                    if (numberofNeigbours < 2) {
                        deleteGrid[x][y] = 1
                        deleteCells = true;
                    }
                    if (numberofNeigbours > 3) {
                        deleteGrid[x][y] = 1
                        deleteCells = true;
                    }
                } else {
                    if (numberofNeigbours == 3) {
                        createGrid[x][y] = 1
                        createCells = true;
                    }
                }
            }
        }

        if (createCells) {
            cellService.createWithCoordinateGrid(createGrid, grid)
        }
        if (deleteCells) {
            cellService.deleteWithCoordinateGrid(deleteGrid, grid)
        }

        def responseData = [
                'cellList': cellList, 'gridGeneration': grid.gridGeneration
        ]
        render responseData as JSON

    }


}
