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
