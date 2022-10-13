//
//  ProfilesInteractor.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright (c) 2022 Tatiana Bugdai. All rights reserved.
//

import UIKit
import CoreStore

protocol ProfilesBusinessLogic {
    func didTriggerViewReadyEvent()
    func didTapAddButton()
    func didTapCheckmarkView(at indexPath: IndexPath)
    func didSelectRow(at indexPath: IndexPath)
}

class ProfilesInteractor: ProfilesBusinessLogic, ProfilesInput {
    
    var output: ProfilesOutput?
    
    var presenter: ProfilesPresentationLogic?
    var router: ProfilesRoutingLogic?
    
    var monitor: ListMonitor<Profile>!    
    var mode: ProfilesMode = .present
    
    func configure(mode: ProfilesMode) {
        self.mode = mode
    }
    
    func didTriggerViewReadyEvent() {
        
        monitor = try? CoreStoreDefaults.dataStack.monitorList(
            From<Profile>(),
            OrderBy<Profile>(.ascending("id"))
        )
        monitor.addObserver(self)
        presenter?.presentProfiles(monitor, mode: mode)
    }
    
    func didTapAddButton() {
        router?.openProfile(profile: nil, mode: .create)
    }
    
    func didTapCheckmarkView(at indexPath: IndexPath) {
        
        try? CoreStoreDefaults.dataStack.perform(
            asynchronous: { (transaction) in
                guard let profiles = try? transaction.fetchAll(
                        From<Profile>(),
                        OrderBy<Profile>(.ascending("id"))
                      ) else { return }
                
                for profile in profiles {
                    profile.isSelected = profile.id == profiles[indexPath.row].id
                }
            },
            completion: { [weak self] _ in
                
                guard let profile = try? CoreStoreDefaults.dataStack.fetchOne(From<Profile>(),
                                                                              Where<Profile>(\.isSelected == true)) else { fatalError() }
                
                switch self?.mode {
                case .select:
                    self?.output?.didSelectProfile(profile)
                    self?.router?.close(transitionType: .dismiss)
                default:
                    break
                }
            }
        )
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        router?.openProfile(profile: monitor[indexPath], mode: .edit)
    }
}

extension ProfilesInteractor: ListObserver {
    
    typealias ListEntityType = Profile
    
    func listMonitorDidChange(_ monitor: ListMonitor<Profile>) {
        presenter?.presentProfiles(monitor, mode: mode)
    }
    func listMonitorDidRefetch(_ monitor: ListMonitor<Profile>) {
        presenter?.presentProfiles(monitor, mode: mode)
    }
}
