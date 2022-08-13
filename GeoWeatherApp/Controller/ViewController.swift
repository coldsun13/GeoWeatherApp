import UIKit
import MapKit

final class ViewController: UIViewController {
    
    private enum UserInterface {
        case weatherMap
        case cityTemperature
    }
    
    // MARK: Private
    // MARK: - Outlets
    private let tableView = UITableView()
    private let locationManager = CLLocationManager()
    private let getTemperatureButton = UIButton()
    private let getLocationButton = UIButton()
    
    // MARK: Private
    // MARK: Properties
    private var selectedLatitude: Double = 0.0
    private var selectedLongitude: Double = 0.0
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
        setupTableView()
    }
    
    // MARK: Private
    // MARK: - Setups
    private func addSubviews() {
        view.addSubviews(tableView,
                         getTemperatureButton,
                         getLocationButton)
    }
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        getTemperatureButton.translatesAutoresizingMaskIntoConstraints = false
        getTemperatureButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        getTemperatureButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -100).isActive = true
        
        getLocationButton.translatesAutoresizingMaskIntoConstraints = false
        getLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        getLocationButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -100).isActive = true
        
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 35/255, alpha: 1.0)
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: MapTableViewCell.identifier)
        tableView.register(TemperatureTableViewCell.self, forCellReuseIdentifier: TemperatureTableViewCell.identifier)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .weatherMap:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell {
                cell.mapView.delegate = self
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row] {
        case .weatherMap:
            return 400
        case .cityTemperature:
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Weather"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: header.bounds.width, height: header.bounds.height)
        header.textLabel?.textAlignment = .left
        header.textLabel?.textColor = .white
    }
}

//MARK: InfoAboutUserDelegate
extension ViewController: InfoAboutUserDelegate {
    func setInfo(_ info: OpenWeatherData) {
        weather = info
    }
}
