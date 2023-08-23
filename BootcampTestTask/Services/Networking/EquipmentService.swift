import Foundation

class EquipmentService {
    var session: URLSession
    var dataTask: URLSessionDataTask?
    let link = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func fetchEquimpents<T: Decodable>(
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        completion: @escaping (Result<T, ServiceError>) -> Void
    ) {
        #if DEBUG

        if ProcessInfo.processInfo.arguments.contains("mock") {
            let _ = [
                EquipmentDto(date: "2022-02-25", day: 2, aircraft: 10, helicopter: 7, tank: 80, apc: 560, fieldArtillery: 49, mrl: 4, militaryAuto: 100, fuelTank: 60, drone: 0, navalShip: 2, antiAircraftWarfare: 0, specialEquipment: nil, mobileSRBMSystem: nil, greatestLossesDirection: nil, vehiclesAndFuelTanks: nil, cruiseMissiles: nil),
                EquipmentDto(date: "2022-03-22", day: 27, aircraft: 99, helicopter: 123, tank: 509, apc: 1556, fieldArtillery: 80, mrl: 1000, militaryAuto: 70, fuelTank: 36, drone: 36, navalShip: 3, antiAircraftWarfare: 100, specialEquipment: 1100, mobileSRBMSystem: 100, greatestLossesDirection: "City", vehiclesAndFuelTanks: 100, cruiseMissiles: 100)
            ]
        }

        #endif

        dataTask?.cancel()
        
        guard let url = URL(string: link) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidUrl))
            }
            return
        }

        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponseStatus))
                }
                return
            }

            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.dataTaskError(error!.localizedDescription)))
                }
                return
            }

            guard let jsonData = data else {
                DispatchQueue.main.async {
                    completion(.failure(.corruptData))
                }
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = keyDecodingStrategy

            do {
                let decodedData = try decoder.decode(T.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error.localizedDescription)))
                }
            }
        })

        dataTask?.resume()
    }
}
