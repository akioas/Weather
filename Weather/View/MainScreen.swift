

import UIKit
import SDWebImage

class MainScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let leftId = "left"
    private let rightId = "right"
    var weatherData = [WeatherData]()
    let controller = WeatherController()
    
    @IBAction func toFavouritesScreen(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let secondVc = storyboard.instantiateViewController(withIdentifier: "Favourites") as! FavouriteScreen
        var favourites = [WeatherData]()
        for (cityData) in weatherData {
            if controller.isFavourite(city: cityData.name ?? "") {
                favourites.append(cityData)
            }
        }
        secondVc.weatherData = favourites
            present(secondVc, animated: true, completion: nil)
    }
    @IBOutlet weak var lTable: UITableView!
    @IBOutlet weak var rTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
            .addObserver(self,
                         selector:#selector(refresh(_:)),
                         name: .weatherRequest,
                         object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector:#selector(reloadData),
                         name: .reloadData,
                         object: nil)
        WeatherRequest().makeRequest()
        configureTable(identifier: leftId, table: rTable)
        configureTable(identifier: rightId, table: lTable)
        
    }
    
    func configureTable(identifier: String, table: UITableView) {
        table.register(Cell.self, forCellReuseIdentifier: identifier)

        table.dataSource = self
        table.isScrollEnabled = false
        table.delegate = self
    }
    
    @objc func refresh(_ notification: NSNotification) {
        if let data = notification.userInfo?[Notification.Name.weatherRequest] as? [WeatherData] {
            self.weatherData = data
            reloadData()
        }
        
    }
    @objc func reloadData() {
        DispatchQueue.main.async {
            self.rTable.reloadData()
            self.lTable.reloadData()
        }
    }
    
}

extension MainScreen {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rTable {
            return weatherData.count / 2
        } else {
            if (weatherData.count % 2 == 1) {
                return weatherData.count / 2 + 1
            } else {
                return weatherData.count / 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == lTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftId, for: indexPath) as! LeftCell

            
            let index = indexPath.row * 2
            
          
            configureCell(cell: cell, index: index)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: rightId, for: indexPath) as! Cell
            let index = ((indexPath.row + 1) * 2) - 1
            configureCell(cell: cell, index: index)
            return cell
        }
        
    }
    
    func configureCell(cell: Cell, index: Int) {
        cell.imgView?.image = UIImage(systemName: "rays")
        cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.cellLabel?.font = UIFont.systemFont(ofSize: 12)
        if (index) < weatherData.count {
            if let text = (weatherData[index].name) {
                cell.cellLabel?.text = text
            }
            if let icon = weatherData[index].weather?.first?.icon {
                cell.imgView?.sd_setImage(with: URL(string:( "https://openweathermap.org/img/wn/" + icon + "@2x.png")), placeholderImage: UIImage(systemName: "rays"))
            }
            
            if let temp = weatherData[index].main?.temp {
                cell.rightLabel?.font = UIFont.systemFont(ofSize: 12)
                cell.rightLabel?.text = String(Int(temp - 273.15)) + "°C"

                if let description = weatherData[index].weather?.first?.description {
                    cell.weatherLabel?.font = UIFont.systemFont(ofSize: 10)
                    cell.weatherLabel?.text = description
                }
            }
            
        }
        if controller.isFavourite(city: weatherData[index].name ?? "") {
            cell.favView.image = UIImage(systemName: "heart.fill")
        } else {
            cell.favView.image = UIImage(systemName: "heart")
        }
        cell.favView.tintColor = .red
        cell.favView.tag = index
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))

        cell.favView.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if tappedImage.image == UIImage(systemName: "heart") {
            tappedImage.image = UIImage(systemName: "heart.fill")
            controller.addToFavourites(city: weatherData[(tappedImage.tag)].name ?? "")
        } else {
            tappedImage.image = UIImage(systemName: "heart")
            controller.removeFromFavourites(city: weatherData[(tappedImage.tag)].name ?? "")
        }
    }

}

class Cell: UITableViewCell {
    
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var favView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
}
class LeftCell: Cell {
    
}

