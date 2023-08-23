import UIKit

class EquipmentContentView: UIView {
    let tableView = EquipmentTableView()
    let indicator = UIActivityIndicatorView().apply {
        $0.hidesWhenStopped = true
        $0.stopAnimating()
    }

    let tryAgainButton = PrimaryButton()

    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .systemBackground
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addElements() {
        addAutoLayoutSubviews(tableView, indicator, tryAgainButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryAgainButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
