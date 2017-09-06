package second_project

class Cell {

    Integer age
    Integer x
    Integer y
    Grid grid

    static hasMany = [neighbour: Cell]

    static constraints = {
        age nullable: true
        x min: 0
        y min: 0
        neighbour max: 8
        grid nullable: true
    }
}
