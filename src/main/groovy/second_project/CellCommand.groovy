package second_project

import grails.validation.Validateable


class CellCommand implements Validateable {

    CellCommand(){}

    CellCommand(Cell cell){
        id = cell.id
        x = cell.x
        y = cell.y
        grid = cell.grid
    }

    Long id
    Integer x
    Integer y
    Grid grid

    static constraints = {
        id nullable: true
        x min: 0
        y min: 0
        grid nullable: true
    }

}
