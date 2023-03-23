
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
        table.backgroundColor = .systemGray6
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
        cell.backgroundColor = .systemGray6
        let index = indexPath.row
        cell.selectionStyle = .none
        let text = (weatherData[index].name ?? "") + "\n" + (weatherData[index].weather?.first?.description ?? "")

        let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])

        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]

        attributedString.addAttributes(boldFontAttribute, range: (text as NSString).range(of: (weatherData[index].name ?? "")))

        cell.textLabel?.attributedText = attributedString
        cell.textLabel?.numberOfLines = 0
        let windText = String(weatherData[index].wind?.speed ?? 0) + " m/s"
        let tempText = WeatherController().getTemp(weatherData[index].main?.temp ?? 0.0)
        
        let accView = UIView()
        accView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        let lLabel = UILabel()
        lLabel.frame = CGRect(x: 20, y: 0, width: 60, height: 50)
        lLabel.text = windText
        lLabel.font = UIFont.systemFont(ofSize: 14)
        lLabel.textColor = .systemIndigo
        let rLabel = UILabel()
        rLabel.frame = CGRect(x: 90, y: 0, width: 60, height: 50)
        rLabel.text = tempText
        rLabel.font = UIFont.systemFont(ofSize: 14)
        rLabel.textColor = .systemPink
        accView.addSubview(rLabel)
        accView.addSubview(lLabel)
        accView.layer.cornerRadius = 3
        accView.layer.borderColor = UIColor.secondarySystemFill.cgColor
        accView.layer.borderWidth = 1
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

