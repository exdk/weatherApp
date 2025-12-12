struct Particle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: CGFloat
}

struct RainView: View {
    @State private var particles: [Particle] = (0..<100).map { _ in
        Particle(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                 y: CGFloat.random(in: -600...0),
                 size: CGFloat.random(in: 2...5),
                 speed: CGFloat.random(in: 4...10))
    }
    
    var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(Color.blue.opacity(0.6))
                    .frame(width: particle.size, height: particle.size * 2)
                    .position(x: particle.x, y: particle.y)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                for i in particles.indices {
                    particles[i].y += particles[i].speed
                    if particles[i].y > UIScreen.main.bounds.height {
                        particles[i].y = -10
                        particles[i].x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
                    }
                }
            }
        }
    }
}

struct SnowView: View {
    @State private var particles: [Particle] = (0..<80).map { _ in
        Particle(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                 y: CGFloat.random(in: -600...0),
                 size: CGFloat.random(in: 3...7),
                 speed: CGFloat.random(in: 1...3))
    }
    
    var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: particle.size, height: particle.size)
                    .position(x: particle.x, y: particle.y)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
                for i in particles.indices {
                    particles[i].y += particles[i].speed
                    particles[i].x += sin(particles[i].y / 20)
                    if particles[i].y > UIScreen.main.bounds.height {
                        particles[i].y = -10
                        particles[i].x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
                    }
                }
            }
        }
    }
}
