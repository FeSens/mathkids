import SwiftUI

struct SettingsView: View {
    @Bindable var settings = SettingsManager.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section("Audio") {
                    Toggle(isOn: $settings.soundEnabled) {
                        Label("Sound Effects", systemImage: "speaker.wave.2.fill")
                    }
                    .accessibilityIdentifier("soundToggle")

                    Toggle(isOn: $settings.hapticsEnabled) {
                        Label("Haptic Feedback", systemImage: "hand.tap.fill")
                    }
                    .accessibilityIdentifier("hapticsToggle")
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .accessibilityIdentifier("settingsDone")
                }
            }
        }
    }
}
