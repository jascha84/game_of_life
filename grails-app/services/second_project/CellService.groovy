package second_project

import grails.gorm.transactions.Transactional

@Transactional
class CellService {


    def list(params) {
        Cell.list(params)
    }

    Cell save(CellCommand cellCommand) throws Exception {
        def cellList = Cell.withCriteria {
            eq 'x', cellCommand.x
            eq 'y', cellCommand.y
        }
        if (cellList) {
            return cell.first()
        }
        if (!cellCommand.hasErrors()) {
            def cell = new Cell(
                    x: cellCommand.x,
                    y: cellCommand.y
            ).save()

            cellCommand.grid.addToCells(cell)

            cell
        } else {
            throw Exception
        }

    }

    void createWithCoordinate(Integer x, Integer y, Grid grid) {
        def cell = new Cell(
                x: x,
                y: y,
        ).save()
        grid.addToCells(cell)
    }

    void delete(Cell cell) {
        cell.delete()
    }

    void deleteWithCoordinateGrid(deleteGrid, Grid grid) {
        def cellsInGrid = grid.getCells().collect({it.id})

        Cell.where {
            or {
                for (def x = 0; x < grid.x; x++) {
                    for (def y = 0; y < grid.y; y++) {
                        if (deleteGrid[x][y] == 1) {
                            and {
                                eq 'x', x+1
                                eq 'y', y+1
                            }
                        }
                    }
                }
            }
            id in cellsInGrid
        }.list().toArray().clone().each {
            grid.removeFromCells(it)
            it.delete()
        }
    }

    void createWithCoordinateGrid(Object createGrid, Grid grid) {
        for (def x = 0; x < createGrid.length; x++) {
            for (def y = 0; y < createGrid[x].length; y++) {
                if (createGrid[x][y] == 1){
                    createWithCoordinate(x+1,y+1,grid)
                }
            }
        }
        return
    }
}
