

import UIKit

class MainScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let leftId = "left"
    private let rightId = "right"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTable {
            return cities.count / 2
        } else {
            if (cities.count % 2 == 1) {
                return cities.count / 2 + 1
            } else {
                return cities.count / 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == rightTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: rightId, for: indexPath as IndexPath)
            cell.textLabel!.text = "\(cities[indexPath.row * 2])"
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftId, for: indexPath as IndexPath)
            
            if (((indexPath.row + 1) * 2) - 1) < cities.count {
                cell.textLabel!.text = "\(cities[((indexPath.row + 1) * 2) - 1])"
                cell.selectionStyle = .none
            }
            return cell
        }
                
    }
    
    
    @IBOutlet weak var leftTable: UITableView!
    @IBOutlet weak var rightTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherRequest().makeRequest()
        configureTable(identifier: leftId, table: leftTable)
        configureTable(identifier: rightId, table: rightTable)
        
    }
    
    func configureTable(identifier: String, table: UITableView) {
        table.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        table.dataSource = self
        table.isScrollEnabled = false
        table.delegate = self
    }

}

