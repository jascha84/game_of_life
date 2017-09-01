package second_project

import grails.gorm.transactions.Transactional

@Transactional
class CellService {


    def list() {
        Cell.list()
    }
}
