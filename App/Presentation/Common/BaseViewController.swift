import UIKit
import RxSwift

class BaseViewController: UIViewController {

    let viewModel: BaseViewModelProtocol

    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(buttonHasBeenSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let bag = DisposeBag()

    init(title: String, viewModel: BaseViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        button.setTitle(title, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        observeViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }

    @objc
    private func buttonHasBeenSelected() {
        viewModel.buttonHasBeenSelected()
    }

    func addBackNavigationButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(backBarButtonSelected)
        )
    }

    @objc
    private func backBarButtonSelected() {
        viewModel.backBarButtonSelected()
    }

    private func observeViewModel() {
        viewModel
            .popUpAlert
            .subscribe { [weak self] title in
                self?.presentAlert(for: title)
            }
            .disposed(by: bag)
    }

    private func presentAlert(for title: String) {
        if presentedViewController != nil {
            dismiss(animated: false)
        }

        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
            self?.viewModel.popUpActionHasBeenSelected()
        }))

        present(alert, animated: true)
    }

    private func setup() {
        view.backgroundColor = .white
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
