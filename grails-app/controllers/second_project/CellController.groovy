package second_project

import grails.converters.*

class CellController {

    def cellService

    def index(Integer max) {
        params.max = Math.min(max ?: 100, 1000)
        def cellList = cellService.list(params)
        respond cellList, model: [cellList: cellList, cellCount: cellList.size()]
    }

    def show(Cell cell){
        [cell: cell]
    }

    def save (CellCommand cellCommand){
        if (cellCommand.validate()){
            cellService.save(cellCommand)
        } else {
            notValid(cellCommand.errors.toString())
        }
    }

    private deleteCell (Cell cell){
        if (cell == null){
            notFound()
            return
        }

        if (cell.id == null){
            def cellList = Cell.withCriteria {
                eq 'x', cell.x
                eq 'y', cell.y
                eq 'grid', cell.grid
            }
            if (cellList) {
                cell = cellList.first()
            }
        }
        cellService.delete(cell)
    }

    def deleteJson (Cell cell){
        deleteCell(cell)

        def responseData = [
                'status': "OK"
        ]
        render responseData as JSON
    }

    def delete (Cell cell){
        deleteCell(cell)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cell.label', default: 'Cell'), cell.id])
                redirect action: "index", method: "GET"
            }
        }
    }

    def notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message')
                redirect action: "index", method: "GET"
            }
        }
    }

    def notValid(String message) {
        request.withFormat {
            form multipartForm {
                flash.message = message
                redirect action: "index", method: "GET"
            }
        }
    }
}
