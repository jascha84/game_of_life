package second_project

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT

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


    def create(CellCommand cellCommand){
        cellCommand.clearErrors()
        [cellCommand: cellCommand]
    }

    def save (CellCommand cellCommand){
        def cell = cellService.save(cellCommand)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cell.label', default: 'Cell'), cell.id])
                redirect cell
            }
            '*' {respond cell, [status: CREATED]}
        }
    }

    def edit (CellCommand cellCommand){
        cellCommand.clearErrors()

        def cell = Cell.get(cellCommand.id)
        cellCommand.x = cell.x
        cellCommand.y = cell.y

        [cellCommand: cellCommand]
    }

    def update (CellCommand cellCommand){
        if (cellCommand == null){
            notFound()
            return
        }

        def cell = cellService.save(cellCommand)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cell.label', default: 'Cell'), cell.id])
                redirect cell
            }
            '*' {respond cell, [status: OK]}
        }
    }

    def delete (Cell cell){
        if (cell == null){
            notFound()
        }
        if (cell.id == null && cell.x != null && cell.y != null && cell.grid){
            def cellList = Cell.withCriteria {
                eq 'x', cell.x
                eq 'y', cell.y
                eq 'grid', cell.grid
            }
            if (cellList){
                cell = cellList.first()
            }
        }

        cellService.delete(cell)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cell.label', default: 'Cell'), cell.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cell.label', default: 'Cell'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

}
