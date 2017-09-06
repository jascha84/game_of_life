package second_project

class Cell {

    Integer x
    Integer y
    Grid grid

    static constraints = {
        x min: 0
        y min: 0
        grid nullable: true
    }
}
