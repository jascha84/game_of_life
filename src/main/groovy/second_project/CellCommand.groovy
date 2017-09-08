package second_project

import grails.validation.Validateable


class CellCommand implements Validateable {

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
