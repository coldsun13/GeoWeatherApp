import MapKit
import UIKit

final class MapView: UIView {
    // MARK: Private
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private let map = MKMapView()
    private let locationButton = UIButton()
    private let getTemperatureButton = UIButton()
    private let getLocationButton = UIButton()
    private var selectedLatitude: Double = 53.904541
    private var selectedLongitude: Double = 27.561523
    
    weak var delegate: InfoAboutUserDelegate?
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
    
    // MARK: Private
    // MARK: - Setups
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
        
        getTemperatureButton.translatesAutoresizingMaskIntoConstraints = false
        getLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        getTemperatureButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -25).isActive = true
        getTemperatureButton.leadingAnchor.constraint(equalTo: map.leadingAnchor, constant: 10).isActive = true
        
        getLocationButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -25).isActive = true
        getLocationButton.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: -10).isActive = true
    }
    
    private func addSubviews() {
        addSubview(map)
        map.addSubview(getTemperatureButton)
        map.addSubview(getLocationButton)
    }
    
    private func addSetups() {
        addViewSetups()
        setupUI()
    }
    
    private func addViewSetups() {
        backgroundColor = UIColor(red: 36/255,
                                  green: 34/255,
                                  blue: 49/255,
                                  alpha: 1.0)
        layer.cornerRadius = 15
    }
    
    // MARK: - Actions
    // MARK: Private
    
    @objc private func getMyLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        
        let myLatitude = locationManager.location?.coordinate.latitude
        let myLongitude = locationManager.location?.coordinate.longitude
        let myLocation = CLLocationCoordinate2D(
            latitude: myLatitude ?? 53.904541,
            longitude: myLongitude ?? 27.561523
        )
        let coordinatesRegion = MKCoordinateRegion(
            center: myLocation,
            latitudinalMeters: 300,
            longitudinalMeters: 300
        )
        map.setRegion(coordinatesRegion, animated: true)
        
        let pointInMyLocation = MKPointAnnotation()
        pointInMyLocation.coordinate = CLLocationCoordinate2D(
            latitude: myLatitude ?? 53.904541,
            longitude: myLongitude ?? 27.561523
        )
        pointInMyLocation.title = "My location"
        map.addAnnotation(pointInMyLocation)
        
        selectedLatitude = myLatitude ?? 53.904541
        selectedLongitude = myLongitude ?? 27.561523
    }
    
    @objc private func weatherInMyLocation() {
        APIManager.instance.getTheWeather(
            myLatitude: selectedLatitude,
            myLongitude: selectedLongitude) { data in
                self.delegate?.setInfo(data)
            }
    }
    
    private func setupUI() {
        let configuratorForWeatherButton = UIImage.SymbolConfiguration(
            pointSize: 30,
            weight: .bold,
            scale: .large
        )
        
        let myWeaterButtonImage = UIImage(
            systemName: "cloud.sun",
            withConfiguration: configuratorForWeatherButton)
        
        getTemperatureButton.setImage(myWeaterButtonImage, for: .normal)
        getTemperatureButton.addTarget(self,
                                       action: #selector(weatherInMyLocation),
                                       for: .touchUpInside)
        
        let myLocationButtonImage = UIImage(
            systemName: "location.circle.fill",
            withConfiguration: configuratorForWeatherButton
        )
        
        getLocationButton.setImage(
            myLocationButtonImage,
            for: .normal
        )
        
        getLocationButton.addTarget(self,
                                    action: #selector(getMyLocation),
                                    for: .touchUpInside)
        
    }
}
