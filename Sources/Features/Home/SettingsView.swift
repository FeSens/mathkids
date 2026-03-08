import SwiftUI
import SwiftData

struct SettingsView: View {
    @Bindable var settings = SettingsManager.shared
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var showResetConfirmation = false

    var body: some View {
        NavigationStack {
            List {
                Section("Audio") {
                    Toggle(isOn: $settings.soundEnabled) {
                        Label("Sound Effects", systemImage: settings.soundEnabled ? "speaker.wave.2.fill" : "speaker.slash.fill")
                    }
                    .accessibilityIdentifier("soundToggle")
                    .animation(.spring(duration: 0.3), value: settings.soundEnabled)

                    Toggle(isOn: $settings.hapticsEnabled) {
                        Label("Haptic Feedback", systemImage: settings.hapticsEnabled ? "hand.tap.fill" : "hand.raised.slash.fill")
                    }
                    .accessibilityIdentifier("hapticsToggle")
                    .animation(.spring(duration: 0.3), value: settings.hapticsEnabled)
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundStyle(.secondary)
                    }
                }

                Section {
                    Button(role: .destructive) {
                        showResetConfirmation = true
                    } label: {
                        Label("Reset All Stats", systemImage: "trash.fill")
                    }
                    .accessibilityIdentifier("resetStatsButton")
                }
            }
            .confirmationDialog("Reset all stats?", isPresented: $showResetConfirmation, titleVisibility: .visible) {
                Button("Reset", role: .destructive) {
                    let service = StatsService(modelContainer: modelContext.container)
                    service.resetStats()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will permanently delete all your progress, achievements, and stats.")
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
