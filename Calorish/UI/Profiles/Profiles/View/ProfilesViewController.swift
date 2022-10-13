//
//  ProfilesViewController.swift
//  Calorish
//
//  Created by admin on 13.05.2022.
//  Copyright (c) 2022 Tatiana Bugdai. All rights reserved.
//

import UIKit
import Rswift

protocol ProfilesDisplayLogic: AnyObject {
    func displayProfiles(_ viewModel: ProfilesViewModel)
}

class ProfilesViewController: UIViewController, ProfilesDisplayLogic {
    
    var interactor: ProfilesBusinessLogic?
    
    private var viewModel: ProfilesViewModel?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.didTriggerViewReadyEvent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.profilesTitle()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.plus,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapAddButton))

        tableView.register(R.nib.profileCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = ProfileCell.height
        tableView.estimatedRowHeight = ProfileCell.height        
    }
    
    func displayProfiles(_ viewModel: ProfilesViewModel) {
        navigationItem.largeTitleDisplayMode = viewModel.largeTitleDisplayMode
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    @objc private func didTapAddButton() {
        interactor?.didTapAddButton()
    }
}

extension ProfilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileCell,
                                                 for: indexPath)
        guard let cellViewModel = viewModel?.cells[indexPath.row] else { fatalError() }
        cell?.setup(with: cellViewModel)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension ProfilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectRow(at: indexPath)
    }
}

extension ProfilesViewController: ProfileCellDelegate {
    func didTapCheckmarkView(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        interactor?.didTapCheckmarkView(at: indexPath)
    }
}

