struct WeatherBackground: View {
    var temp: Double
    var hour: Int
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: gradientColors()),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 2), value: hour)
    }
    
    func gradientColors() -> [Color] {
        if hour >= 6 && hour < 18 {
            switch temp {
            case ..<0: return [Color.blue.opacity(0.8), Color.white.opacity(0.5)]
            case 0..<15: return [Color.cyan.opacity(0.7), Color.blue.opacity(0.5)]
            case 15..<25: return [Color.orange.opacity(0.6), Color.yellow.opacity(0.4)]
            default: return [Color.red.opacity(0.7), Color.orange.opacity(0.5)]
            }
        } else {
            return [Color.black.opacity(0.9), Color.blue.opacity(0.8)]
        }
    }
}
