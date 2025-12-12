struct SunMoonView: View {
    @State private var rotate = false
    var isDay: Bool
    
    var body: some View {
        ZStack {
            if isDay {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 80, height: 80)
                    .shadow(color: .yellow.opacity(0.7), radius: 20)
                
                ForEach(0..<12) { i in
                    Rectangle()
                        .fill(Color.yellow.opacity(0.7))
                        .frame(width: 2, height: 20)
                        .offset(y: -50)
                        .rotationEffect(.degrees(Double(i) * 30))
                }
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: rotate)
            } else {
                Circle()
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 60, height: 60)
                    .shadow(color: .white.opacity(0.6), radius: 15)
            }
        }
        .offset(x: 120, y: -150)
        .onAppear { rotate = true }
    }
}
