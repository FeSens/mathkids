import Foundation
import Observation

@Observable
@MainActor
final class SettingsManager {
    static let shared = SettingsManager()

    var soundEnabled: Bool {
        didSet { UserDefaults.standard.set(soundEnabled, forKey: "soundEnabled") }
    }

    var hapticsEnabled: Bool {
        didSet { UserDefaults.standard.set(hapticsEnabled, forKey: "hapticsEnabled") }
    }

    private init() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "soundEnabled") == nil {
            defaults.set(true, forKey: "soundEnabled")
        }
        if defaults.object(forKey: "hapticsEnabled") == nil {
            defaults.set(true, forKey: "hapticsEnabled")
        }
        self.soundEnabled = defaults.bool(forKey: "soundEnabled")
        self.hapticsEnabled = defaults.bool(forKey: "hapticsEnabled")
    }
}
