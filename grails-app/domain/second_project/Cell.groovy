package second_project

class Cell {

    Integer x
    Integer y

    static belongsTo = [Grid]

    static constraints = {
        x min: 0
        y min: 0
    }
}
