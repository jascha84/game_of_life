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

    void deleteWithCoordinates(Integer x, Integer y, Grid grid) {
        def delCellList = Cell.withCriteria {
            eq 'x', x
            eq 'y', y
            eq 'grid', grid
        }
        if (delCellList) {
            def delCell = delCellList.first()
            if (delCell) {
                delete(delCell)
            }
        }
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

//        Cell.where {
//            'in' 'x', x and {'in' 'y', y}

//            'in' 'x', x1 and {'in' 'y', y1}

//            'in' 'x', x2 and {'in' 'y', y2}
//
//            eq 'grid', grid
//        }.deleteAll()
    }
}
