import SwiftUI

struct ContentView: View {
    @StateObject var vm = WeatherViewModel()
    @State private var selectedTab = "3 часа"
    
    var body: some View {
        NavigationView {
            ZStack {
                let hour = Calendar.current.component(.hour, from: Date())
                let isDay = hour >= 6 && hour < 18
                
                if let firstTemp = vm.hourlyWeather.first?.temp {
                    WeatherBackground(temp: firstTemp, hour: hour)
                }
                
                SunMoonView(isDay: isDay)
                
                CloudView()
                CloudView().offset(y: 50).scaleEffect(0.7)
                
                if let icon = vm.hourlyWeather.first?.weather.first?.icon {
                    if icon.contains("rain") || icon.contains("drizzle") {
                        RainView()
                    } else if icon.contains("snow") {
                        SnowView()
                    }
                }
                
                VStack {
                    Picker("Прогноз", selection: $selectedTab) {
                        Text("3 часа").tag("3 часа")
                        Text("До конца дня").tag("До конца дня")
                        Text("Завтра").tag("Завтра")
                        Text("Выходные").tag("Выходные")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(getWeatherForSelectedTab(), id: \.dt) { weather in
                                WeatherCard(weather: weather)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Погода")
            .task { await vm.fetchWeather() }
        }
    }
    
    func getWeatherForSelectedTab() -> [HourlyWeather] {
        switch selectedTab {
        case "3 часа":
            return vm.hourlyWeather
        case "До конца дня":
            return Array(vm.hourlyWeather.prefix(6))
        case "Завтра":
            return vm.dailyWeather.count > 1 ? [vm.dailyWeather[1]].map { HourlyWeather(dt: $0.dt, temp: $0.temp.day, humidity: $0.humidity, weather: $0.weather) } : []
        case "Выходные":
            return vm.dailyWeather.dropFirst().prefix(2).map { HourlyWeather(dt: $0.dt, temp: $0.temp.day, humidity: $0.humidity, weather: $0.weather) }
        default:
            return []
        }
    }
}
