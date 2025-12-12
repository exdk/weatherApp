struct WeatherCard: View {
    var weather: HourlyWeather
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text(hourFormatter(weather.dt))
                .font(.headline)
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(animate ? 10 : -10))
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
            } placeholder: {
                ProgressView()
            }
            Text("\(Int(weather.temp))°C")
                .font(.title2)
            Text("Влажность: \(weather.humidity)%")
                .font(.caption)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 5)
        .onAppear { animate = true }
    }
    
    func hourFormatter(_ time: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
