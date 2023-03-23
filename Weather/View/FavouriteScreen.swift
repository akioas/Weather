
import UIKit

class FavouriteScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var weatherData = [WeatherData]()
    let idebtifier = "fav"
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.self, forCellReuseIdentifier: idebtifier)
        
        table.dataSource = self
        table.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
    }
}

extension FavouriteScreen {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idebtifier, for: indexPath)
        let index = indexPath.row
        cell.selectionStyle = .none
        let text = (weatherData[index].name ?? "") + "\n" + (weatherData[index].weather?.first?.description ?? "")
        let windText = String(weatherData[index].wind?.speed ?? 0) + " m/s"
        let tempText = String(Int((weatherData[index].main?.temp ?? 0.0) - 273.15)) + " °C"
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = text
        
        let accView = UIView()
        accView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        let lLabel = UILabel()
        lLabel.frame = CGRect(x: 0, y: 0, width: 70, height: 50)
        lLabel.text = windText
        let rLabel = UILabel()
        rLabel.frame = CGRect(x: 80, y: 0, width: 70, height: 50)
        rLabel.text = tempText
        accView.addSubview(rLabel)
        accView.addSubview(lLabel)
        cell.accessoryView = accView
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            WeatherController().removeFromFavourites(city: weatherData[indexPath.row].name ?? "")
            weatherData.remove(at: indexPath.row)
            table.reloadData()
            NotificationCenter.default.post(name: .reloadData,
                                            object: nil)
        }
    }
}



extension Notification.Name {
    static var reloadData: Notification.Name {
        return .init(rawValue: "reload data") }
}

