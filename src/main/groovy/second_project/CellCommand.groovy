package second_project

import grails.validation.Validateable


class CellCommand implements Validateable {

    Integer age

    static constraints = {
        age(min: 1)
    }

}
