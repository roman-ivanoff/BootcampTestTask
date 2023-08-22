import UIKit

class EquipmentViewController: UIViewController {
    let contentView = EquipmentContentView()
    let equipmentModel = EquipmentModel()
    var searchController: UISearchController!

    var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }

    private var initialBottomInset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("russia_losses_equipment", comment: "")
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self

        setupSearchController()
        setupViews()
        fetchEquipments()
        addNotificationObservers()
    }

    override func loadView() {
        view = contentView
    }

    private func setupViews() {
        hideViews(
            contentView.tableView,
            contentView.tryAgainButton
        )
        contentView.tryAgainButton.addTarget(self, action: #selector(reload(_:)), for: .touchUpInside)
    }

    private func fetchEquipments() {
        if Reachability.shared.isConnectedToNetwork() {
            equipmentModel.fetchEquipments { [weak self] _ in
                guard let self else {
                    return
                }
                self.toggleActivityIndicator(indicator: contentView.indicator, isLoading: equipmentModel.isLoading)
                self.reloadTableView()
            } onError: { [weak self] error in
                guard let self else {
                    return
                }
                self.toggleActivityIndicator(indicator: contentView.indicator, isLoading: equipmentModel.isLoading)
                self.showAlert(
                    title: NSLocalizedString("something_went_wrong", comment: ""),
                    message: error.localizedDescription,
                    action: showTryAgainButton
                )
            }
            toggleActivityIndicator(indicator: contentView.indicator, isLoading: equipmentModel.isLoading)
        } else {
            toggleActivityIndicator(indicator: contentView.indicator, isLoading: false)
            showAlert(
                title: NSLocalizedString("something_went_wrong", comment: ""),
                message: NSLocalizedString("no_internet_connection", comment: ""),
                action: showTryAgainButton
            )
        }
    }

    private func setupSearchController() {

        contentView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.returnKeyType = .done
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("search_by_date", comment: "")
        searchController.searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchController.searchBar.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )

        definesPresentationContext = true
    }

    private func reloadTableView() {
        contentView.tableView.reloadData()
        showHiddenViews(contentView.tableView)
    }

    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            initialBottomInset = contentView.tableView.contentInset.bottom
            let newBottomInset = keyboardSize.height - view.safeAreaInsets.bottom
            contentView.tableView.contentInset.bottom = newBottomInset
            contentView.tableView.verticalScrollIndicatorInsets.bottom = newBottomInset
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        contentView.tableView.contentInset.bottom = initialBottomInset
        contentView.tableView.verticalScrollIndicatorInsets.bottom = initialBottomInset
    }

    @objc private func reload(_ sender: UIButton) {
        if Reachability.shared.isConnectedToNetwork() {
            fetchEquipments()
            contentView.tryAgainButton.isHidden = true
        } else {
            toggleActivityIndicator(indicator: contentView.indicator, isLoading: false)
            showAlert(
                title: NSLocalizedString("something_went_wrong", comment: ""),
                message: NSLocalizedString("no_internet_connection", comment: ""),
                action: showTryAgainButton
            )
        }
    }

    private func showTryAgainButton() {
        showHiddenViews(contentView.tryAgainButton)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension EquipmentViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }

    func filterContentForSearchText(_ searchText: String) {
        var equipmentsArray: [EquipmentDto] = []
        equipmentModel.filteredEquipments.removeAll()

        equipmentsArray = equipmentModel.equipments.filter {
            $0.date.contains(searchText.lowercased())
        }

        if !equipmentsArray.isEmpty {
            equipmentModel.filteredEquipments = equipmentsArray
        }

        contentView.tableView.reloadData()
    }
}

extension EquipmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ?
        equipmentModel.filteredEquipments.count :
        equipmentModel.equipments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()

        if let equipmentCell = tableView.dequeueReusableCell(
            withIdentifier: EquipmentTableViewCell.identifier,
            for: indexPath) as? EquipmentTableViewCell {
            let equipment: EquipmentDto
            if isFiltering {
                equipment = equipmentModel.filteredEquipments[indexPath.row]
            } else {
                equipment = equipmentModel.equipments[indexPath.row]
            }
            equipmentCell.configure(date: equipment.date, day: String(equipment.day))
            cell = equipmentCell
        }

        return cell
    }
}
