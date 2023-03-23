
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
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 0, width: 150, height: 30)
        label.text = weatherData[index].name
        cell.contentView.addSubview(label)
        let windLabel = UILabel()
        windLabel.frame = CGRect(x: 170, y: 15, width: 100, height: 30)
        windLabel.text = String(weatherData[index].wind?.speed ?? 0) + " m/s"
        cell.contentView.addSubview(windLabel)
        let teempLabel = UILabel()
        teempLabel.frame = CGRect(x: 270, y: 15, width: 100, height: 30)
        teempLabel.text = String(Int((weatherData[index].main?.temp ?? 0.0) - 273.15)) + " °C"
        cell.contentView.addSubview(teempLabel)
        let description = UILabel()
        description.frame = CGRect(x: 20, y: 30, width: 150, height: 30)
        description.text = weatherData[index].weather?.first?.description
        cell.contentView.addSubview(description)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
