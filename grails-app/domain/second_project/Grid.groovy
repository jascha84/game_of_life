package second_project

class Grid {

    Integer x
    Integer y
    String name
    Integer gridGeneration

    static hasMany = [cells: Cell]

    static constraints = {
        x min: 0
        y min: 0
        gridGeneration min: 0
    }
}
