//import UIKit
//import MapKit
//
//private let locationManager = CLLocationManager()
//
//enum Coordinates {
//    static let latitude = locationManager.location?.coordinate.latitude
//    static let longitude = locationManager.location?.coordinate.longitude
//}
//
//final class MapView: UIView {
//
//    // MARK: - Properties
//    // MARK: Private
//
//    private let map = MKMapView()
//    private let locationButton = UIButton()
//    private let checkWeatherButton = UIButton()
//
//    // MARK: - Properties
//    // MARK: Private
//    private var selectedLatitude = 0.0
//    private var selectedLongitude = 0.0
//
//    // MARK: - LIfecycle
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubviews()
//        setLocation()
//        addConstraints()
//        setupUI()
//    }
//
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func addConstraints() {
//        map.translatesAutoresizingMaskIntoConstraints = false
//        map.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        map.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        map.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        map.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//
//        locationButton.translatesAutoresizingMaskIntoConstraints = false
//        locationButton.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: -50).isActive = true
//        locationButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -50).isActive = true
//        locationButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        locationButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
//
//        checkWeatherButton.translatesAutoresizingMaskIntoConstraints = false
//        checkWeatherButton.leadingAnchor.constraint(equalTo: map.leadingAnchor, constant: 50).isActive = true
//        checkWeatherButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -50).isActive = true
//        checkWeatherButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        checkWeatherButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//
//    private func addSubviews() {
//        addSubview(map)
//        map.addSubviews(locationButton,
//                        checkWeatherButton)
//    }
//
//    private func setLocation() {
//        let location = CLLocationCoordinate2D(latitude: 53.904541, longitude: 27.561523)
//        let coordinateRegion = MKCoordinateRegion(
//            center: location,
//            latitudinalMeters: 10000,
//            longitudinalMeters: 10000)
//        map.setRegion(coordinateRegion, animated: true)
//
//    }
//    private func setupUI() {
//        let configurator = UIImage.SymbolConfiguration(pointSize: 40,
//                                                       weight: .bold,
//                                                       scale: .large)
//
//        let resultImage = UIImage(systemName: "location.circle.fill",
//                                  withConfiguration: configurator)
//        locationButton.setImage(resultImage, for: .normal)
//        locationButton.addTarget(self, action: #selector(myLocationDidTapped), for: .touchUpInside)
//
//        let secondResultImage = UIImage(systemName: "cloud.fill",
//                                        withConfiguration: configurator)
//        checkWeatherButton.setImage(secondResultImage, for: .normal)
//        checkWeatherButton.addTarget(self, action: #selector(printWeather), for: .touchUpInside)
//    }
//
//    // MARK: - Actions
//    // MARK: Private
//    @objc func myLocationDidTapped() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        map.showsUserLocation = true
//
//        let myLatitude = locationManager.location?.coordinate.latitude
//        let myLongitude = locationManager.location?.coordinate.longitude
//
//        let myLocation = CLLocationCoordinate2D(
//            latitude: myLatitude ?? 53.904541,
//            longitude: myLongitude ?? 27.561523
//        )
//        let coordinatesRegion = MKCoordinateRegion(center: myLocation, latitudinalMeters: 100, longitudinalMeters: 100)
//        map.setRegion(coordinatesRegion, animated: true)
//
//        selectedLatitude = myLatitude ?? 53.904541
//        selectedLongitude = myLongitude ?? 27.561523
//
//    }
//    @objc func printWeather() {
////        APIManager.instance.getTheWeather(
////            myLatitude: selectedLatitude,
////            myLongitude: selectedLongitude) { data in
////                print(data.main.temp)
////            }
//    }
//    }

import MapKit
import UIKit

private let locationManager = CLLocationManager()

enum Coordinates {
    static let latitude = locationManager.location?.coordinate.latitude
    static let longitude = locationManager.location?.coordinate.longitude
}

final class MapView: UIView {
    // MARK: - Properties

    // MARK: Private

    private let map: MKMapView = .init()
    private let locationButton = UIButton()

    // MARK: - LIfecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
        addSetups()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addConstraints() {
        addMapConstraints()
        addLocationButtonConstraints()
    }
    
    private func addMapConstraints() {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: topAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func addLocationButtonConstraints() {
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.centerYAnchor.constraint(equalTo: map.centerYAnchor).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: -10).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        addSubview(map)
        map.addSubview(locationButton)
    }
    
    private func addSetups() {
        addViewSetups()
        addMapAndLocationButtonSetups()
    }
    
    private func addViewSetups() {
        backgroundColor = UIColor(red: 36/255,
                                  green: 34/255,
                                  blue: 49/255,
                                  alpha: 1.0)
        layer.cornerRadius = 15
    }
    
    private func addMapAndLocationButtonSetups() {
        map.layer.cornerRadius = 15
        let resultimage = UIImage(systemName: "location")
        locationButton.setImage(resultimage, for: .normal)
        locationButton.tintColor = .white
        locationButton.addAction(UIAction(handler: { _ in
            self.clickLocationButton()
        }), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    // MARK: Private
    
    private func clickLocationButton() {
        map.showsUserLocation = true
        let location = CLLocationCoordinate2D(latitude: Coordinates.latitude ?? 53.904541,
                                              longitude: Coordinates.longitude ?? 27.561523)
        let region = MKCoordinateRegion(center: location,
                                        latitudinalMeters: 2000,
                                        longitudinalMeters: 2000)
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.setRegion(region, animated: true)
    }
}
