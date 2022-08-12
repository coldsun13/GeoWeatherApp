import Alamofire

struct APIManager {

    static let instance = APIManager()
    static let keyFromWeather: String = "e8574db00f2d9d99c8474f371f3212f6"

    enum Constant {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
    }

    enum PointsOfURL {
        static let weather = "/weather"
        static let latitude = "?lat="
        static let longitude = "&lon="
        static let appiID = "&appid="
    }

    enum Metrics {
        static let metric = "&units=metric"
        static let imperial = "&units=imperial"
    }

    func getTheWeather(myLatitude: Double,
                       myLongitude: Double,
                       completion: @escaping ((OpenWeatherData) -> Void)) {

        AF.request(Constant.baseURL +
                   PointsOfURL.weather +
                   PointsOfURL.latitude +
                   "\(myLatitude)" +
                   PointsOfURL.longitude +
                   "\(myLongitude)" +
                   PointsOfURL.appiID +
                   APIManager.keyFromWeather +
                   Metrics.metric).responseDecodable(of: OpenWeatherData.self) {
            response in
            switch response.result {
            case .success(let model):
                completion(model)
            case.failure(let error):
                print(error)
            }
        }
    }
    private init() { }
}
