import UIKit

class EquipmentTableViewCell: UITableViewCell, BTTIdentifiable {
    let dateLabel = UILabel()
    let dayLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addViews()
        backgroundColor = .white
        separatorInset = .zero
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(date: String, day: String) {
        dateLabel.text = String(format: NSLocalizedString("date_title", comment: ""), date)
        dayLabel.text = String(format: NSLocalizedString("day_title", comment: ""), day)
    }

    private func addViews() {
        addAutoLayoutSubviews(dateLabel, dayLabel)

        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            dateLabel.trailingAnchor.constraint(equalTo: dayLabel.leadingAnchor, constant: 4),

            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
}
