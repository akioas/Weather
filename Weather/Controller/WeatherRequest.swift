

import Foundation

class WeatherRequest {
    
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    private let key = "8b85ae65928a36eba0b842e724b69598"
    
    var weatherData: [WeatherData] = []
    let urlDownloadQueue = DispatchQueue(label: "urlqueue")
    let urlDownloadGroup = DispatchGroup()
    
    func makeRequest() {
        cities.forEach { city in
            let url = baseUrl + "?q=" + city.replacingOccurrences(of: " ", with: "%20") + ",ru&APPID=" + key
            self.urlDownloadGroup.enter()
            var request = URLRequest(url: URL(string: url)!)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard error == nil else {
                        print("\(String(describing: error))")
                        self.urlDownloadQueue.async {
                            self.urlDownloadGroup.leave()
                        }
                        return
                    }
                    guard let _ = data else {
                        print("Response Data is empty")
                        self.urlDownloadQueue.async {
                            self.urlDownloadGroup.leave()
                        }
                        return
                    }
                    if let httpResponse = response as? HTTPURLResponse {
                        let status = httpResponse.statusCode
                        if status == 200 {
                            if let data = data {
                                do {
                                    let json = try JSONDecoder().decode(WeatherData.self, from: data)
                                    print(json)
                                    self.urlDownloadQueue.async {
                                        self.weatherData.append(json)
                                        self.urlDownloadGroup.leave()
                                    }
                                }
                                catch {
                                    self.urlDownloadQueue.async {
                                        self.urlDownloadGroup.leave()
                                    }
                                }
                                
                            }
                        } else {
                            self.urlDownloadQueue.async {
                                self.urlDownloadGroup.leave()
                            }
                            if let data = data {
                                do {
                                    let json = try JSONDecoder().decode(WeatherErrorData.self, from: data)
                                    
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    }
                }
            }.resume()
        }
        urlDownloadGroup.notify(queue: DispatchQueue.global()) {
            self.weatherData = self.weatherData.sorted(by:
                                                        {cities.firstIndex(of: $0.name ?? "") ?? 0 < cities.firstIndex(of: $1.name ?? "") ?? 0})
            print("!!!")
                NotificationCenter.default.post(name: .weatherRequest,
                                                object: nil, userInfo: [Notification.Name.weatherRequest : self.weatherData]) 
        }
    }
    
    
}

extension Notification.Name {
    static var weatherRequest: Notification.Name {
          return .init(rawValue: "weather request") }
}

