import Foundation

class EquipmentModel {
    let equipmentService = EquipmentService()
    var equipments: [EquipmentDto] = []
    var isLoading = false
    var filteredEquipments: [EquipmentDto] = [EquipmentDto]()

    func fetchEquipments(
        onSuccess: @escaping([EquipmentDto]) -> Void,
        onError: @escaping(ServiceError) -> Void
    ) {
        isLoading = true

        equipmentService.fetchEquimpents { [weak self] (result: Result<[EquipmentDto], ServiceError>) in
            guard let self else {
                return
            }

            switch result {

            case let .success(data):
                self.equipments = data
                self.isLoading = false
                onSuccess(data)
            case let .failure(error):
                isLoading = false
                onError(error)
            }
        }
    }
}
