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
