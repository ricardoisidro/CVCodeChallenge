import UIKit

class MainTableViewController: UITableViewController {
    
    private let tableViewModelController = TableViewModelController()
    @IBOutlet private weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushLoadingView()
        imageView?.image = UIImage(named: "picture")
        configure()
        tableViewModelController.completeDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.popLoadingView()
            }
        }
        tableViewModelController.fill()
        tableViewModelController.loadDidFail = { [weak self] in
            self?.popLoadingView()
            self?.alertFailure()
        }
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
    
    private func alertFailure() {
        let alert = UIAlertController(title: NSLocalizedString("MessageTitle", comment: ""),
                                      message: NSLocalizedString("MessageContent", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("MessageButton", comment: ""),
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
