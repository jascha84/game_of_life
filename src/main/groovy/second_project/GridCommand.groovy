package second_project

import grails.validation.Validateable

class GridCommand implements Validateable {

    Integer x
    Integer y
    String name

    static constraints = {
        x min: 0
        y min: 0
        name nullable: true
    }

}
