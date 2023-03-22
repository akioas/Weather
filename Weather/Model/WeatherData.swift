import Foundation

struct WeatherErrorData: Decodable {
    let cod: Int?
    let message: String?
}

struct WeatherData: Decodable {
    let cod: Int?
    let message: String?
    let coord: Coordinates?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int64?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
}

struct Coordinates: Decodable {
    let lon: Double?
    let lat: Double?
}

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Decodable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let grndLevel: Int?
    
}

struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct Clouds: Decodable {
    let all: Int?
}

struct Sys: Decodable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int64?
    let sunset: Int64?
}

