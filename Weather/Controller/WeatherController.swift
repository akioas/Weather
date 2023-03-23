

import Foundation

class WeatherController {
    let data = CitiesData()
    func addToFavourites(city: String) {
        data.addToFavourites(city: city)
    }
    
    func removeFromFavourites(city: String) {
        data.removeFromFavourites(city: city)
    }
    
    func isFavourite(city: String) -> Bool {
        data.isFavourite(city: city)
    }
}
