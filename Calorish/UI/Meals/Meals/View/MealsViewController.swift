//
//  MealsViewController.swift
//  Calorish
//
//  Created by admin on 18.05.2022.
//  Copyright (c) 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol MealsDisplayLogic: AnyObject {
    func display(viewModel: MealsViewModel)
}

class MealsViewController: UIViewController, MealsDisplayLogic {
    
    var interactor: MealsBusinessLogic?
    
    @IBOutlet private var tableView: UITableView!
    private let tableHeaderView = MealsHeaderView()
    
    private var viewModel: MealsViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Triggers here because we can change active profile at profiles tab
        // and then get back here
        interactor?.didTriggerViewReadyEvent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.mealsTitle()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.plus,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.commonUser(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapProfileButton))
        
        tableHeaderView.frame = CGRect(origin: CGPoint.zero,
                                       size: CGSize(width: tableView.frame.width,
                                                    height: MealsHeaderView.height))
        tableView.tableHeaderView = tableHeaderView
        tableView.register(R.nib.mealCell)
        tableView.rowHeight = MealCell.height
        tableView.estimatedRowHeight = MealCell.height
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func display(viewModel: MealsViewModel) {
        
        self.viewModel = viewModel
        
        navigationItem.leftBarButtonItem?.title = viewModel.profileName
        tableHeaderView.setup(with: viewModel.header)
        tableView.reloadData()        
    }
    
    @objc private func didTapAddButton() {
        interactor?.didTapAddButton()
    }
    
    @objc private func didTapProfileButton() {
        interactor?.didTapProfileButton()
    }
}

extension MealsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.table.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.table.sections[section].section?.time
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.table.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mealCell,
                                                 for: indexPath)
        guard let cellViewModel = viewModel?.table.cellAt(indexPath) else { fatalError() }
        cell?.setup(with: cellViewModel)
        return cell ?? UITableViewCell()
    }
}

extension MealsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectRow(at: indexPath)
    }
}
