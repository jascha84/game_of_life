package second_project

import grails.gorm.transactions.Transactional

@Transactional
class CellService {


    def list(params) {
        Cell.list(params)
    }

    Cell save(CellCommand cellCommand) throws Exception{
        def cell = Cell.withCriteria {
            eq 'x', cellCommand.x
            eq 'y', cellCommand.y
            eq 'grid', cellCommand.grid
        }
        if (cell){
            return cell.first()
        }
        if (!cellCommand.hasErrors()){
            new Cell(
                    age: cellCommand.age,
                    x: cellCommand.x,
                    y: cellCommand.y,
                    neighbour: cellCommand.neighbourList,
                    grid: cellCommand.grid
            ).save()
        } else {
            throw Exception
        }
    }

    Cell createWithCoordinate(Integer x, Integer y, Grid grid) {
        def cell = new Cell(
                age: 1,
                x: x,
                y: y,
                grid: grid
        ).save()

        grid.addToCells(cell)
        return cell
    }

    void delete(Cell cell){
        cell.delete()
    }

    void deleteWithCoordinates(Integer x, Integer y, Grid grid){
        def delCellList = Cell.withCriteria {
            eq 'x', x
            eq 'y', y
            eq 'grid', grid
        }
        if (delCellList){
            def delCell = delCellList.first()
            if (delCell){
                grid.removeFromCells(delCell)
                delete(delCell)
            }
        }
    }
}
