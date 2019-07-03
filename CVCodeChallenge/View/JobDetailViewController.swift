//
//  JobDetailViewController.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 7/2/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

protocol JobDetailViewControllerDelegate: class {
    func jobDetailViewControllerDidTapClose(_ jobDetailViewController: JobDetailViewController)
}

class JobDetailViewController: UIViewController {

    @IBOutlet private weak var modalView: UIView?
    @IBOutlet private weak var closeButton: UIButton?
    
    private var modalHeightConstraint: NSLayoutConstraint?
    private var modalWidthConstraint: NSLayoutConstraint?
    private var tableViewModelController = TableViewModelController()
    
    weak var delegate: JobDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addConstraints()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        modalWidthConstraint?.isActive = false
        modalHeightConstraint?.isActive = false
        if UIDevice.current.orientation.isLandscape {
            modalWidthConstraint = modalView?.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30)
            modalHeightConstraint = modalView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.80)
        } else {
            modalWidthConstraint = modalView?.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
            modalHeightConstraint = modalView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30)
            
        }
        modalWidthConstraint?.isActive = true
        modalHeightConstraint?.isActive = true
    }
    
    func load(_ information: TableViewModelController) {
        
    }
    
    @IBAction private func tappedButton(_ sender: UIButton) {
        delegate?.jobDetailViewControllerDidTapClose(self)
    }
    
    private func configure() {
        modalView?.layer.cornerRadius = 10
        modalView?.layer.masksToBounds = true
        closeButton?.setTitle(NSLocalizedString("ModalClose", comment: ""), for: .normal)
    }
    
    private func addConstraints() {
        modalWidthConstraint = modalView?.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
        modalHeightConstraint = modalView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30)
        modalWidthConstraint?.isActive = true
        modalHeightConstraint?.isActive = true
    }
}
