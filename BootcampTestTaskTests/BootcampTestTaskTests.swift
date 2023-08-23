import XCTest
@testable import BootcampTestTask

final class BootcampTestTaskTests: XCTestCase {
    var urlSession: URLSession!

    override func setUpWithError() throws {
        let service = EquipmentService(session: urlSession)
        let sampleData = getSampleData()
        let mockData = try JSONEncoder().encode(sampleData)

        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }

        let expectation = XCTestExpectation(description: "response")

        service.fetchEquimpents { (result: Result<[EquipmentDto], ServiceError>) in
           switch result {
           case .success(let success):
               XCTAssertEqual(sampleData, success)
           case .failure(let error):
               XCTAssertEqual(error, ServiceError.corruptData)
           }
        }

        wait(for: [expectation], timeout: 1)
    }

    private func getSampleData() -> [EquipmentDto] {
        [
            EquipmentDto(date: "2022-02-25", day: 2, aircraft: 10, helicopter: 7, tank: 80, apc: 560, fieldArtillery: 49, mrl: 4, militaryAuto: 100, fuelTank: 60, drone: 0, navalShip: 2, antiAircraftWarfare: 0, specialEquipment: nil, mobileSRBMSystem: nil, greatestLossesDirection: nil, vehiclesAndFuelTanks: nil, cruiseMissiles: nil),
            EquipmentDto(date: "2022-03-22", day: 27, aircraft: 99, helicopter: 123, tank: 509, apc: 1556, fieldArtillery: 80, mrl: 1000, militaryAuto: 70, fuelTank: 36, drone: 36, navalShip: 3, antiAircraftWarfare: 100, specialEquipment: 1100, mobileSRBMSystem: 100, greatestLossesDirection: "City", vehiclesAndFuelTanks: 100, cruiseMissiles: 100)
        ]
    }
}
