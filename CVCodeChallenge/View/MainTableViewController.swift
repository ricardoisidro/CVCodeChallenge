//
//  ViewController.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 7/1/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private let tableViewModelController = TableViewModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewModelController.delegate = self
        pushLoadingView()
        configure()
        tableViewModelController.fill()
    }
    
    private func configure() {
        navigationItem.title = NSLocalizedString("Title", comment: "Table title")
        tableView.dataSource = tableViewModelController
        tableView.delegate = tableViewModelController
    }
    
    private func pushLoadingView() {
        let loadingViewController = LoadingViewController()
        navigationController?.present(loadingViewController, animated: false, completion: nil)
    }
    
    private func popLoadingView() {
        navigationController?.dismiss(animated: false, completion: nil)
    }
}

extension MainTableViewController: TableViewModelControllerDelegate {
    
    func tableViewModelControllerDidFinishLoadInformation(_ tableViewModelController: TableViewModelController) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.popLoadingView()
        }
    }
    
    
}



