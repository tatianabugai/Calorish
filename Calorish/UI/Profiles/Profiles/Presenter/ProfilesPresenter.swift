//
//  ProfilesPresenter.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright (c) 2022 Tatiana Bugdai. All rights reserved.
//

import UIKit
import CoreStore

protocol ProfilesPresentationLogic {
    func presentProfiles(_ profiles: ListMonitor<Profile>, mode: ProfilesMode)
}

class ProfilesPresenter: ProfilesPresentationLogic {
    weak var viewController: ProfilesDisplayLogic?
    
    func presentProfiles(_ profiles: ListMonitor<Profile>, mode: ProfilesMode) {
        
        let largeTitleDisplayMode = mode.largeTitleDisplayMode
        let cells = profiles.objectsInAllSections().map { $0.viewModel() }
        let profilesViewModel = ProfilesViewModel(largeTitleDisplayMode: largeTitleDisplayMode,
                                                  cells: cells)
        
        viewController?.displayProfiles(profilesViewModel)
    }
}
