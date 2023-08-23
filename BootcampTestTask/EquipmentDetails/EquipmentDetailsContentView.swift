import UIKit

class EquipmentDetailsContentView: UIView {
    let dayLabel = UILabel()
    let aircraftLabel = UILabel()
    let helicopterLabel = UILabel()
    let tankLabel = UILabel()
    let apcLabel = UILabel()
    let fieldArtilleryLabel = UILabel()
    let mrlLabel = UILabel() 
    let militaryAutoLabel = UILabel()
    let fuelTankLabel = UILabel()
    let droneLabel = UILabel()
    let navalShipLabel = UILabel()
    let antiAircraftWarfareLabel = UILabel()
    let specialEquipmentLabel = UILabel()
    let mobileSRBMSystemLabel = UILabel()
    let greatestLossesDirectionLabel = UILabel()
    let vehiclesAndFuelTanksLabel = UILabel()
    let cruiseMissilesLabel = UILabel()

    private let scrollView = UIScrollView()
    private let scrollStackViewContainer = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .systemBackground
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addElements() {
        addAutoLayoutSubviews(scrollView)
        scrollView.addAutoLayoutSubviews(scrollStackViewContainer)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 16),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        configureContainerView()
    }

    private func configureContainerView() {
        scrollStackViewContainer.addArrangedSubview(dayLabel)
        scrollStackViewContainer.addArrangedSubview(aircraftLabel)
        scrollStackViewContainer.addArrangedSubview(helicopterLabel)
        scrollStackViewContainer.addArrangedSubview(tankLabel)
        scrollStackViewContainer.addArrangedSubview(apcLabel)
        scrollStackViewContainer.addArrangedSubview(fieldArtilleryLabel)
        scrollStackViewContainer.addArrangedSubview(mrlLabel)
        scrollStackViewContainer.addArrangedSubview(militaryAutoLabel)
        scrollStackViewContainer.addArrangedSubview(fuelTankLabel)
        scrollStackViewContainer.addArrangedSubview(droneLabel)
        scrollStackViewContainer.addArrangedSubview(navalShipLabel)
        scrollStackViewContainer.addArrangedSubview(antiAircraftWarfareLabel)
        scrollStackViewContainer.addArrangedSubview(specialEquipmentLabel)
        scrollStackViewContainer.addArrangedSubview(mobileSRBMSystemLabel)
        scrollStackViewContainer.addArrangedSubview(greatestLossesDirectionLabel)
        scrollStackViewContainer.addArrangedSubview(vehiclesAndFuelTanksLabel)
        scrollStackViewContainer.addArrangedSubview(cruiseMissilesLabel)
    }

    func configure(with equipment: EquipmentDto?) {
        guard let equipment = equipment else {
            return
        }
        dayLabel.text = String(format: NSLocalizedString("day_title", comment: ""), String(equipment.day))
        aircraftLabel.text = String(format: NSLocalizedString("aircraft", comment: ""), String(equipment.aircraft))
        helicopterLabel.text = String(format: NSLocalizedString("helicopter", comment: ""), String(equipment.helicopter))
        tankLabel.text = String(format: NSLocalizedString("tank", comment: ""), String(equipment.tank))
        apcLabel.text = String(format: NSLocalizedString("apc", comment: ""), String(equipment.apc))
        fieldArtilleryLabel.text = String(format: NSLocalizedString("field_artillery", comment: ""), String(equipment.fieldArtillery))
        mrlLabel.text = String(format: NSLocalizedString("mrl", comment: ""), String(equipment.mrl))
        showLabelIfEquipmentElementExists(label: militaryAutoLabel, element: equipment.militaryAuto, labelText: NSLocalizedString("military_auto", comment: ""))
        showLabelIfEquipmentElementExists(label: fuelTankLabel, element: equipment.fuelTank, labelText: NSLocalizedString("fuel_tank", comment: ""))
        droneLabel.text = String(format: NSLocalizedString("drone", comment: ""), String(equipment.drone))
        navalShipLabel.text = String(format: NSLocalizedString("naval_ship", comment: ""), String(equipment.navalShip))
        antiAircraftWarfareLabel.text = String(format: NSLocalizedString("anti_aircraft_warfare", comment: ""), String(equipment.antiAircraftWarfare))
        showLabelIfEquipmentElementExists(label: specialEquipmentLabel, element: equipment.specialEquipment, labelText: NSLocalizedString("special_equipment", comment: ""))
        showLabelIfEquipmentElementExists(label: mobileSRBMSystemLabel, element: equipment.mobileSRBMSystem, labelText: NSLocalizedString("mobile_SRBM_system", comment: ""))
        showLabelIfEquipmentElementExists(label: greatestLossesDirectionLabel, element: equipment.greatestLossesDirection, labelText: NSLocalizedString("greatest_losses_direction", comment: ""))
        showLabelIfEquipmentElementExists(label: vehiclesAndFuelTanksLabel, element: equipment.vehiclesAndFuelTanks, labelText: NSLocalizedString("vehicles_and_fuel_tanks", comment: ""))
        showLabelIfEquipmentElementExists(label: cruiseMissilesLabel, element: equipment.cruiseMissiles, labelText: NSLocalizedString("cruise_missiles", comment: ""))
    }

    private func showLabelIfEquipmentElementExists(label: UILabel, element: Any?, labelText: String) {
        if let element = element {
            label.isHidden = false
            label.text = String(format: labelText, String(describing: element))
        } else {
            label.isHidden = true
        }
    }
}
