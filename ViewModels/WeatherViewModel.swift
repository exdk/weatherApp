import Foundation
import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var hourlyWeather: [HourlyWeather] = []
    @Published var dailyWeather: [DailyWeather] = []
    
    private let apiKey = "YOUR_API_KEY"
    private let lat = "55.7558"
    private let lon = "37.6173"
    
    func fetchWeather() async {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&units=metric&appid=\(apiKey)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
            hourlyWeather = Array(response.hourly.prefix(12))
            dailyWeather = response.daily
        } catch {
            print("Error fetching weather:", error)
        }
    }
}
