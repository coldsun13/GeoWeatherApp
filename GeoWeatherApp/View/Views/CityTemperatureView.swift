import UIKit

final class CityTemperatureView: UIView {
    // MARK: - Properties
    // MARK: Private
    
    private let stackView = UIStackView()
    private let geolocationStackView = UIStackView()
    private let cityLabel = UILabel()
    private let countryLabel = UILabel()
    private let scaleLabel = UILabel()
    
    // MARK: - LIfecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addSetups()
        addStackViewConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func set(_ geolocatian: String, _ scale: Double, _ country: String) {
        cityLabel.text = geolocatian
        scaleLabel.text = String(format: "%.0f", scale) + "º"
        countryLabel.text = country
    }
    
    // MARK: Private
    // MARK: - Setups
    private func addStackViewConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addAllArrangedSubviews(geolocationStackView,
                                         scaleLabel)
        geolocationStackView.addAllArrangedSubviews(cityLabel,
                                                    countryLabel)
    }
    
    private func addSetups() {
        addViewSetups()
        addStackViewSetups()
        addGeolocationStackViewSetups()
        addCityLabelSetups()
        addCountryLabelSetups()
        addScaleLabelSetups()
    }
    
    private func addViewSetups() {
        backgroundColor = UIColor(red: 36/255, green: 34/255, blue: 49/255, alpha: 1.0)
        layer.cornerRadius = 15
    }
    
    private func addStackViewSetups() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
    }
    
    private func addGeolocationStackViewSetups() {
        geolocationStackView.axis = .vertical
        geolocationStackView.distribution = .fillEqually
        geolocationStackView.alignment = .fill
    }
    
    private func addCityLabelSetups() {
        cityLabel.textAlignment = .left
        cityLabel.textColor = .white
        cityLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func addCountryLabelSetups() {
        countryLabel.text = "BY"
        countryLabel.textAlignment = .left
        countryLabel.textColor = .darkGray
        countryLabel.font = .systemFont(ofSize: 15, weight: .light)
    }
    
    private func addScaleLabelSetups() {
        scaleLabel.textAlignment = .right
        scaleLabel.textColor = .white
        scaleLabel.font = .systemFont(ofSize: 60, weight: .bold)
    }
}
