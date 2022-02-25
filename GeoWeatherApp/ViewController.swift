import UIKit
import MapKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    // MARK: Private
    private let map = MKMapView()
    private let locationManager = CLLocationManager()
    private let locationButton = UIButton()
    private let checkWeatherButton = UIButton()
    
    // MARK: - Properties
    // MARK: Private
    private var selectedLatitude = 0.0
    private var selectedLongitude = 0.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLocation()
        addConstraints()
        setupUI()
    }
    
    // MARK: - Setups
    // MARK: Private
    private func addSubviews() {
        view.addSubview(map)
        map.addSubview(locationButton)
        map.addSubview(checkWeatherButton)
    }
    
    private func addConstraints() {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: -68).isActive = true
        locationButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -68).isActive = true
        locationButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        checkWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        checkWeatherButton.leadingAnchor.constraint(equalTo: map.leadingAnchor, constant: 68).isActive = true
        checkWeatherButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -68).isActive = true
        checkWeatherButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        checkWeatherButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setLocation() {
        let location = CLLocationCoordinate2D(latitude: 53.904541, longitude: 27.561523)
        let coordinateRegion = MKCoordinateRegion(
            center: location,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000)
        map.setRegion(coordinateRegion, animated: true)

    }
    
    private func setupUI() {
        let configurator = UIImage.SymbolConfiguration(pointSize: 40,
                                                       weight: .bold,
                                                       scale: .large)
        
        let resultImage = UIImage(systemName: "location.circle.fill",
                                  withConfiguration: configurator)
        locationButton.setImage(resultImage, for: .normal)
        locationButton.addTarget(self, action: #selector(myLocationDidTapped), for: .touchUpInside)
        
        let secondResultImage = UIImage(systemName: "cloud.fill",
                                        withConfiguration: configurator)
        checkWeatherButton.setImage(secondResultImage, for: .normal)
        checkWeatherButton.addTarget(self, action: #selector(printWeather), for: .touchUpInside)
    }
    
    // MARK: - Actions
    // MARK: Private
    @objc func myLocationDidTapped() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        
        let myLatitude = locationManager.location?.coordinate.latitude
        let myLongitude = locationManager.location?.coordinate.longitude
        
        let myLocation = CLLocationCoordinate2D(
            latitude: myLatitude ?? 53.904541,
            longitude: myLongitude ?? 27.561523
        )
        let coordinatesRegion = MKCoordinateRegion(center: myLocation, latitudinalMeters: 100, longitudinalMeters: 100)
        map.setRegion(coordinatesRegion, animated: true)
        
        selectedLatitude = myLatitude ?? 53.904541
        selectedLongitude = myLongitude ?? 27.561523
        
    }
    
    @objc func printWeather() {
            APIManager.instance.getTheWeather(
                myLatitude: selectedLatitude,
                myLongitude: selectedLongitude) { data in
                    print(data.main.temp)
                }
        }
}

