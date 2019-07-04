import UIKit

class MainTableViewController: UITableViewController {
    
    private let tableViewModelController = TableViewModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushLoadingView()
        tableViewModelController.completeDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.popLoadingView()
            }
        }
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
