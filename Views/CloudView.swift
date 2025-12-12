struct CloudView: View {
    @State private var offset: CGFloat = -200
    
    var body: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 60)
            .foregroundColor(.white.opacity(0.6))
            .offset(x: offset, y: -100)
            .onAppear {
                withAnimation(.linear(duration: 40).repeatForever(autoreverses: false)) {
                    offset = UIScreen.main.bounds.width + 200
                }
            }
    }
}
