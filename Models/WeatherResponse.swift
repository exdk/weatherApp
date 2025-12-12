import Foundation

struct WeatherResponse: Codable {
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct HourlyWeather: Codable, Identifiable {
    let id = UUID()
    let dt: TimeInterval
    let temp: Double
    let humidity: Int
    let weather: [WeatherDetail]
}

struct DailyWeather: Codable, Identifiable {
    let id = UUID()
    let dt: TimeInterval
    let temp: Temp
    let humidity: Int
    let weather: [WeatherDetail]
}

struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
}

struct WeatherDetail: Codable {
    let main: String
    let description: String
    let icon: String
}
