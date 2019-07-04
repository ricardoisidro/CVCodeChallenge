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
        navigationItem.title = "Title".localized()
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
        let alert = UIAlertController(title: "MessageTitle".localized(),
                                      message: "MessageContent".localized(),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "MessageButton".localized(),
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
