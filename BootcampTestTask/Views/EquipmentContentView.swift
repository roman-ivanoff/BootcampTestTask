import UIKit

class EquipmentContentView: UIView {
    let tableView = EquipmentTableView()

    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .white
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addElements() {
        addAutoLayoutSubviews(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
    }
}
