import UIKit
import MapKit

private enum UserInterface {
    case weatherMap
    case cityTemperature
}

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    // MARK: Private
    private let tableView = UITableView()
    private let sections = ["Weather", "Map"]
    private let dataSource: [UserInterface] = [.cityTemperature, .weatherMap]
    private var weather: OpenWeatherData? {
        didSet {
            self.tableView.reloadData()
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
    }
    
    // MARK: - Setups
    // MARK: Private
    private func addSubviews() {
        view.addSubviews(tableView)
    }
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: MapTableViewCell.identifier)
        tableView.register(TemperatureTableViewCell.self, forCellReuseIdentifier: TemperatureTableViewCell.identifier)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .weatherMap:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell {
                return cell
            }
            return UITableViewCell()
            
        case .cityTemperature:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureTableViewCell.identifier, for: indexPath) as? TemperatureTableViewCell {
                cell.cityTemperatureView.set(weather?.name ?? "None", weather?.main.temp ?? 0, weather?.sys.country ?? "None")
                return cell
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section] == "Weather" {
            return 150
        } else if sections[indexPath.section] == "Map" {
            return 400
        }
        return 150
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}
