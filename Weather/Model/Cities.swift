

import Foundation

class CitiesData {
   /*
    let cities = ["Moscow", "Saint Petersburg", "Novosibirsk", "Ekaterinburg", "Kazan'",
    "Nizhny Novgorod", "Chelyabinsk", "Krasnoyarsk", "Samara Oblast", "Ufa",
    "Rostov-on-Don", "Omsk", "Krasnodarskiy Kray", "Voronezh", "Perm",
    "Volgograd", "Saratov", "Tyumen", "Tolyatti", "Barnaul"]
    */
    let cities = ["Moscow", "Saint Petersburg"]
    func addToFavourites(city: String) {
        UserDefaults.standard.set(true, forKey: city)
    }
    
    func removeFromFavourites(city: String) {
        UserDefaults.standard.set(false, forKey: city)
    }
    
    func isFavourite(city: String) -> Bool {
        UserDefaults.standard.bool(forKey: city)
    }
}
