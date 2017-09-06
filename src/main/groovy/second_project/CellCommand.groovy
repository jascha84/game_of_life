package second_project

import grails.validation.Validateable


class CellCommand implements Validateable {

    CellCommand(){}

    CellCommand(Cell cell){
        id = cell.id
        age = cell.age
        x = cell.x
        y = cell.y
        grid = cell.grid
    }

    Integer age
    Long id
    Integer x
    Integer y
    List<Cell> neighbourList = new ArrayList<Cell>()
    Grid grid

    static constraints = {
        id nullable: true
        age min: 1
        x min: 0
        y min: 0
        neighbourList nullable: true
        grid nullable: true
    }

}
