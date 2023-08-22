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
        backgroundColor = .white
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addElements() {
        addAutoLayoutSubviews(tableView, indicator, tryAgainButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0),

            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryAgainButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
