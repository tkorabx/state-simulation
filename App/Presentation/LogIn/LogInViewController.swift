import UIKit

protocol LogInViewModelProtocol: BaseViewModelProtocol {
    func sendCommandsHasBeenSelected()
}

class LogInViewController: BaseViewController {

    init(viewModel: LogInViewModelProtocol) {
        super.init(title: "Log In", viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSendCommandsButton()
    }

    private func addSendCommandsButton() {
        let sendCommandsButton = UIButton(type: .system)
        sendCommandsButton.setTitle("Send Commands", for: .normal)
        sendCommandsButton.addTarget(self, action: #selector(sendCommandsButtonHasBeenSelected), for: .touchUpInside)
        sendCommandsButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(sendCommandsButton)

        NSLayoutConstraint.activate([
            sendCommandsButton.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            sendCommandsButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
        ])
    }

    @objc
    private func sendCommandsButtonHasBeenSelected() {
        // It's simple app so didn't go with complex solution for having exact ViewModel type here
        // That's why I used casting
        if let viewModel = viewModel as? LogInViewModelProtocol {
            viewModel.sendCommandsHasBeenSelected()
        }
    }
}
