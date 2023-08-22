import UIKit

class PrimaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor(named: "primaryBlue")
        setTitle(NSLocalizedString("try_again", comment: ""), for: .normal)
        contentHorizontalAlignment = .center
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentEdgeInsets = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        clipsToBounds = true
        layer.cornerRadius = 8
        isHidden = true
    }
}
