import UIKit

final class TemperatureTableViewCell: UITableViewCell {
    // MARK: - Identifier

    static let identifier = "TemperatureTableViewCell"

    // MARK: - Properties

    // MARK: Private

    let cityTemperatureView = CityTemperatureView()

    // MARK: - LIfecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cityTemperatureView)
        contentView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 35/255, alpha: 1.0)
        addWeatherViewConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Constraints

    // MARK: Private

    private func addWeatherViewConstraints() {
        cityTemperatureView.translatesAutoresizingMaskIntoConstraints = false
        cityTemperatureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cityTemperatureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cityTemperatureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        cityTemperatureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}

