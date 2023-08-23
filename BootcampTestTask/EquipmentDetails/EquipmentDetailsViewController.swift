import UIKit

class EquipmentDetailsViewController: UIViewController {
    // MARK: Properties
    private let contentView = EquipmentDetailsContentView()
    private var equipment: EquipmentDto?

    // MARK: Init
    init(equipment: EquipmentDto) {
        self.equipment = equipment
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        equipment = nil
    }

    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        title = equipment?.date
        contentView.configure(with: equipment)
    }

    override func loadView() {
        view = contentView
    }
}
