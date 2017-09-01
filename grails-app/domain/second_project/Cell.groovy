package second_project

class Cell {

    Integer age

    static hasMany = [neighbour: Cell]

    static constraints = {
        age min: 0
    }
}
