import Foundation

struct QueryService {
    
    func loadConnectionsBetweenStations(depShortCode: String, desShortCode: String, completion: @escaping ([Train]) -> ())
    {
        guard let url = URL(string: "https://rata.digitraffic.fi/api/v1/live-trains/station/\(depShortCode)/\(desShortCode)") else {
            return
        }
        
        httpGet(url: url)
        {
            do {
                let acquiredConnections = try JSONDecoder().decode([Train].self, from: $0)
                completion(acquiredConnections)
            }
            catch let error as NSError {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
    
    func loadTrainStationData(_ completion: @escaping ([Station]) -> ()) {
        guard let url = URL(string: "https://rata.digitraffic.fi/api/v1/metadata/stations") else {
            return
        }
        
        httpGet(url: url) { data in
            do {
                let acquiredStationMeta = try JSONDecoder().decode([Station].self, from: data)
                completion(acquiredStationMeta)
            }
            catch let error as NSError {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
    
    private func httpGet(url: URL, completion: @escaping ((Data) -> ())) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                completion(data)
            }
        }
    }
    
}
