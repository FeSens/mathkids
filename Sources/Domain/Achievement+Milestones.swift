import Foundation

extension Achievement {
    var achievementCardParchmentStyle: String {
        isRareAchievement ? "aged" : "fresh"
    }

    var achievementRequiresEndurance: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardDictumText: String {
        switch category {
        case .mastery: return "To know is to conquer"
        case .streak: return "To persist is to prevail"
        case .score: return "To score is to succeed"
        case .games: return "To play is to begin"
        }
    }

    var achievementCardJadeStyle: String {
        isRareAchievement ? "imperial" : "rough"
    }

    var achievementCheckpointCount: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 5
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCardOpalStyle: String {
        isRareAchievement ? "fire" : "common"
    }

    var achievementRequiresPatience: Bool {
        category == .streak
    }

    var achievementCardEdictText: String {
        switch category {
        case .mastery: return "By decree of mastery"
        case .streak: return "By decree of persistence"
        case .score: return "By decree of excellence"
        case .games: return "By decree of participation"
        }
    }

    var achievementCardAmethystStyle: String {
        isRareAchievement ? "royal" : "pale"
    }

    var achievementProgressSteps: Int {
        switch category {
        case .mastery: return 20
        case .streak: return 7
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardTopazStyle: String {
        isRareAchievement ? "imperial" : "plain"
    }

    var achievementRequiresFocus: Bool {
        category == .score || category == .mastery
    }

    var achievementCardDecreeText: String {
        switch category {
        case .mastery: return "Decree of the Grand Master"
        case .streak: return "Decree of the Faithful"
        case .score: return "Decree of the Champion"
        case .games: return "Decree of the Initiate"
        }
    }

    var achievementCardGarnetStyle: String {
        isRareAchievement ? "deep" : "light"
    }

    var achievementRewardTierLevel: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 4
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCardPeridotStyle: String {
        isRareAchievement ? "vivid" : "pale"
    }

    var achievementRequiresMastery: Bool {
        category == .mastery
    }

    var achievementCardProclamationText: String {
        switch category {
        case .mastery: return "Proclaimed Master"
        case .streak: return "Proclaimed Devotee"
        case .score: return "Proclaimed Marksman"
        case .games: return "Proclaimed Explorer"
        }
    }

    var achievementCardCitrineStyle: String {
        isRareAchievement ? "golden" : "pale"
    }

    var achievementUnlockThresholdPercent: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 0
        case .score: return 90
        case .games: return 0
        }
    }

    var achievementCardTurquoiseStyle: String {
        isRareAchievement ? "polished" : "rough"
    }

    var achievementRequiresParticipation: Bool {
        category == .games
    }

    var achievementCardManifestoText: String {
        switch category {
        case .mastery: return "The Manifesto of Mastery"
        case .streak: return "The Manifesto of Resolve"
        case .score: return "The Manifesto of Glory"
        case .games: return "The Manifesto of Play"
        }
    }

    var achievementCardOnxyStyle: String {
        isRareAchievement ? "obsidian" : "slate"
    }

    var achievementGrandMasterPoints: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 50
        case .score: return 75
        case .games: return 10
        }
    }

    var achievementCardMoonstoneStyle: String {
        isRareAchievement ? "luminous" : "milky"
    }

    var achievementRequiresAccuracy: Bool {
        category == .score || category == .mastery
    }

    var achievementCardCreedText: String {
        switch category {
        case .mastery: return "The Creed of Knowledge"
        case .streak: return "The Creed of Discipline"
        case .score: return "The Creed of Precision"
        case .games: return "The Creed of Exploration"
        }
    }

    var achievementCardAquamarineStyle: String {
        isRareAchievement ? "deep" : "light"
    }

    var achievementPrestigeTier: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 7
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardTanzaniteStyle: String {
        isRareAchievement ? "vivid" : "faded"
    }

    var achievementRequiresCommitment: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardAlexandriteStyle: String {
        isRareAchievement ? "color-changing" : "static"
    }

    var achievementRequiresPerseverance: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardTenetText: String {
        switch category {
        case .mastery: return "Tenet of the Sage"
        case .streak: return "Tenet of the Sentinel"
        case .score: return "Tenet of the Archer"
        case .games: return "Tenet of the Wanderer"
        }
    }

    var achievementCardSpinelStyle: String {
        isRareAchievement ? "brilliant" : "dull"
    }

    var achievementEliteThreshold: Int {
        switch category {
        case .mastery: return 90
        case .streak: return 30
        case .score: return 80
        case .games: return 10
        }
    }

    var achievementCardZirconStyle: String {
        isRareAchievement ? "brilliant" : "muted"
    }

    var achievementRequiresDiscipline: Bool {
        category == .mastery
    }

    var achievementCardDoctrineText: String {
        switch category {
        case .mastery: return "Doctrine of Excellence"
        case .streak: return "Doctrine of Endurance"
        case .score: return "Doctrine of Precision"
        case .games: return "Doctrine of Discovery"
        }
    }

    var achievementCardKunziteStyle: String {
        isRareAchievement ? "vivid" : "pale"
    }

    var achievementVeteranThreshold: Int {
        switch category {
        case .mastery: return 200
        case .streak: return 60
        case .score: return 100
        case .games: return 25
        }
    }

    var achievementCardMorganiteStyle: String {
        isRareAchievement ? "radiant" : "soft"
    }

    var achievementRequiresResilience: Bool {
        category == .streak
    }

    var achievementCardCanonText: String {
        switch category {
        case .mastery: return "Canon of the Learned"
        case .streak: return "Canon of the Devoted"
        case .score: return "Canon of the Skilled"
        case .games: return "Canon of the Eager"
        }
    }

    var achievementCardIoliteStyle: String {
        isRareAchievement ? "deep" : "light"
    }

    var achievementChampionThreshold: Int {
        switch category {
        case .mastery: return 500
        case .streak: return 100
        case .score: return 250
        case .games: return 50
        }
    }
}
