

import Foundation

class CitiesData {
    /*
    static let cities = ["Moscow", "Saint Petersburg", "Novosibirsk", "Ekaterinburg", "Kazan'",
    "Nizhny Novgorod", "Chelyabinsk", "Krasnoyarsk", "Samara Oblast", "Ufa",
    "Rostov-on-Don", "Omsk", "Krasnodarskiy Kray", "Voronezh", "Perm",
    "Volgograd", "Saratov", "Tyumen", "Tolyatti", "Barnaul"]
    */
    let cities = ["Moscow", "Saint Petersburg"]
    func addToFavourites(city: Int) {
        UserDefaults.standard.set(true, forKey: cities[city])
    }
    
    func removeFromFavourites(city: Int) {
        UserDefaults.standard.set(false, forKey: cities[city])
    }
    
    func isFavourite(city: Int) -> Bool {
        UserDefaults.standard.bool(forKey: cities[city])
    }
}
