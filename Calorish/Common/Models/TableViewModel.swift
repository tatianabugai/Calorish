//
//  TableViewModel.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import Foundation

class TableViewModel<SectionViewModel, CellViewModel> {
    
    var sections: [Section]
    
    init(sections: [Section]) {
        self.sections = sections
    }
    
    struct Section {
        var section: SectionViewModel?
        var cells: [CellViewModel]
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return sections[section].cells.count
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func cellAt(_ indexPath: IndexPath) -> CellViewModel {
        return sections[indexPath.section].cells[indexPath.row]
    }
}
