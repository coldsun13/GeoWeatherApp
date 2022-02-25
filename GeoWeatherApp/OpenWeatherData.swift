import Foundation

struct OpenWeatherData: Codable {
    let main: Main
}
struct Main: Codable {
    let temp: Double

}
