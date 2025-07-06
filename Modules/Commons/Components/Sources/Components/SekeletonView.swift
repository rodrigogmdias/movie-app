import SwiftUI

public struct SkeletonView: View {
    @State private var isAnimating = false
    
    public init() {}
    
    public var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay(
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.clear,
                                Color.white.opacity(0.4),
                                Color.clear
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .rotationEffect(.degrees(10))
                    .offset(x: isAnimating ? 400 : -400)
                    .animation(
                        Animation.linear(duration: 1.2)
                            .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            )
            .clipped()
            .onAppear {
                isAnimating = true
            }
    }
}
