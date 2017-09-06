package second_project

class Grid {

    Integer x
    Integer y
    String name

    static hasMany = [cells: Cell]

    static constraints = {
        x min: 0
        y min: 0
    }
}
