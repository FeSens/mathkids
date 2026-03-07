import SwiftUI

struct ShakeEffect: GeometryEffect {
    var shakes: CGFloat

    var animatableData: CGFloat {
        get { shakes }
        set { shakes = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = sin(shakes * .pi * 2) * 10
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}
