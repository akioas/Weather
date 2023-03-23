

import Foundation

class WeatherController {
    let data = CitiesData()
    func addToFavourites(city: Int) {
        data.addToFavourites(city: city)
    }
    
    func removeFromFavourites(city: Int) {
        data.removeFromFavourites(city: city)
    }
    
    func isFavourite(city: Int) -> Bool {
        data.isFavourite(city: city)
    }
}
