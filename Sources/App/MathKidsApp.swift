import SwiftUI
import SwiftData

@main
struct MathKidsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PlayerStats.self)
    }
}
