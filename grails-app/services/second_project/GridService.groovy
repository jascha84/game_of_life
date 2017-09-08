package second_project

import grails.gorm.transactions.Transactional

@Transactional
class GridService {

    def list() {
        Grid.list()
    }

    Grid save(GridCommand gridCommand){
        if (!gridCommand.hasErrors()){
            new Grid(
                    x: gridCommand.x,
                    y: gridCommand.y,
                    name: gridCommand.name,
                    gridGeneration: gridCommand.gridGeneration
            ).save()
        }
    }

    void delete(Grid grid){
        grid.delete()
    }
}
