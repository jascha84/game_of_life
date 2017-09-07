package second_project

import grails.gorm.transactions.Transactional

@Transactional
class CellService {


    def list(params) {
        Cell.list(params)
    }

    Cell save(CellCommand cellCommand) throws Exception {
        def cell = Cell.withCriteria {
            eq 'x', cellCommand.x
            eq 'y', cellCommand.y
            eq 'grid', cellCommand.grid
        }
        if (cell) {
            return cell.first()
        }
        if (!cellCommand.hasErrors()) {
            new Cell(
                    x: cellCommand.x,
                    y: cellCommand.y,
                    grid: cellCommand.grid
            ).save()
        } else {
            throw Exception
        }
    }

    void createWithCoordinate(Integer x, Integer y, Grid grid) {

        def cell = new Cell(
                x: x,
                y: y,
                grid: grid
        ).save()

        grid.addToCells(cell)

    }

    void delete(Cell cell) {
        cell.delete()
    }

    void deleteWithCoordinateGrid(Object deleteGrid, Grid grid) {
        Cell.where {
            or {
                for (def x = 0; x < grid.x; x++) {
                    for (def y = 0; y < grid.y; y++) {
                        if (deleteGrid[x][y] == 1) {
                            and {
                                eq 'x', x+1
                                eq 'y', y+1
                                eq 'grid', grid
                            }
                        }
                    }
                }
            }
        }.deleteAll()
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
