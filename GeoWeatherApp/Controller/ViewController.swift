import UIKit


final class ViewController: UIViewController {
    
    private enum UserInterface {
        case weatherMap
        case cityTemperature
    }

    // MARK: - Outlets
    // MARK: Private
    private let tableView = UITableView()
    private let setTemperature = UIButton()
    private var selectedLatitude: Double = 53.904541
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
        setupUI()
    }
    
    // MARK: - Setups
    // MARK: Private
    private func addSubviews() {
        view.addSubviews(tableView, setTemperature)
    }
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setTemperature.translatesAutoresizingMaskIntoConstraints = false
        setTemperature.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        setTemperature.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -40).isActive = true
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 35/255, alpha: 1.0)
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: MapTableViewCell.identifier)
        tableView.register(TemperatureTableViewCell.self, forCellReuseIdentifier: TemperatureTableViewCell.identifier)
    }
    
    private func setupUI() {
        setTemperature.setImage(UIImage(systemName: "location.circle.fill"),
                                for: .normal)
        setTemperature.addTarget(self,
                                 action: #selector(weatherInMyLocation),
                                 for: .touchUpInside)
    }
    
    @objc private func weatherInMyLocation() {
        APIManager.instance.getTheWeather(
            myLatitude: selectedLatitude,
            myLongitude: selectedLongitude) { data in
                self.weather = data
                self.tableView.reloadData()
            }
    }
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
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
}
