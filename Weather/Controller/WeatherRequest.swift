

import Foundation

class WeatherRequest {
    
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    private let key = "8b85ae65928a36eba0b842e724b69598"
    
    func makeRequest(city: String) {
        let url = baseUrl + "?q=" + city + ",ru&APPID=" + key
        print(url)
        var request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("\(String(describing: error))")
                    return
                }
                guard let _ = data else {
                    print("Response Data is empty")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    let status = httpResponse.statusCode
                    if status == 200 {
                        if let data = data {
                            do {
                                let json = try JSONDecoder().decode(WeatherData.self, from: data)
                                print(json)
                            }
                            catch {
                                
                            }
                            
                        }
                    } else {
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
    
    
}


