import UIKit

class EquipmentTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        showsVerticalScrollIndicator = false
        backgroundColor = UIColor.clear
        separatorStyle = .singleLine
        keyboardDismissMode = .onDrag

        setup()

        register(EquipmentTableViewCell.self, forCellReuseIdentifier: EquipmentTableViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 1
        layer.shadowOffset = .init(width: 0, height: 2)
    }
}
