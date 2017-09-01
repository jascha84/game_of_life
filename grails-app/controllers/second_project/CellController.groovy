package second_project

class CellController {

    def cellService

    def index() {
        def cellList = cellService.list()
        respond cellList, model: [cellList: cellList, cellCount: cellList.size()]
    }

    def create(CellCommand cellCommand){
        cellCommand.clearErrors()
        [cellCommand: cellCommand]
    }
}
