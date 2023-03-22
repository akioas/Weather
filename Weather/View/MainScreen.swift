

import UIKit

class MainScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherRequest().makeRequest(city: "Moscow")
    }


}

