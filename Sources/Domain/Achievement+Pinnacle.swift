import Foundation

extension Achievement {
    var achievementCardCylindriteStyle: String {
        isRareAchievement ? "dark lead cylindrical" : "matte lead"
    }

    var achievementRequiresEndurancePlusPlus: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardResolutionWritSealPlusText: String {
        switch category {
        case .mastery: return "Resolution Writ Seal Plus of the Progenitor"
        case .streak: return "Resolution Writ Seal Plus of the Centurion"
        case .score: return "Resolution Writ Seal Plus of the Conqueror"
        case .games: return "Resolution Writ Seal Plus of the Acolyte"
        }
    }

    var achievementCardFranckeiteStyle: String {
        isRareAchievement ? "greyish black foliated" : "dark iron"
    }

    var achievementDominancePlusThreshold: Int {
        switch category {
        case .mastery: return 400000
        case .streak: return 160000
        case .score: return 350000
        case .games: return 40000
        }
    }

    var achievementCardLivingstoniteStyle: String {
        isRareAchievement ? "blackish grey prismatic" : "ashen"
    }

    var achievementRequiresTenacityPlusPlus: Bool {
        category == .score || category == .mastery
    }

    var achievementCardCompactWritSealPlusText: String {
        switch category {
        case .mastery: return "Compact Writ Seal Plus of the Patriarch"
        case .streak: return "Compact Writ Seal Plus of the Sentinel"
        case .score: return "Compact Writ Seal Plus of the Titan"
        case .games: return "Compact Writ Seal Plus of the Novice"
        }
    }

    var achievementCardStephaniteStyle: String {
        isRareAchievement ? "iron black orthorhombic" : "dark slate"
    }

    var achievementAscendancyPlusThreshold: Int {
        switch category {
        case .mastery: return 500000
        case .streak: return 200000
        case .score: return 450000
        case .games: return 50000
        }
    }

    var achievementCardPolybasiteStyle: String {
        isRareAchievement ? "iron black tabular" : "dark iron"
    }

    var achievementRequiresFortitudePlusPLus: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardOrdinanceWritSealPlusText: String {
        switch category {
        case .mastery: return "Ordinance Writ Seal Plus of the Grandmaster"
        case .streak: return "Ordinance Writ Seal Plus of the Warden"
        case .score: return "Ordinance Writ Seal Plus of the Exemplar"
        case .games: return "Ordinance Writ Seal Plus of the Pupil"
        }
    }

    var achievementCardPearceiteStyle: String {
        isRareAchievement ? "black metallic hexagonal" : "matte black"
    }

    var achievementSupremacyPlusThreshold: Int {
        switch category {
        case .mastery: return 750000
        case .streak: return 300000
        case .score: return 600000
        case .games: return 75000
        }
    }

    var achievementCardPyrargyriteStyle: String {
        isRareAchievement ? "deep ruby red" : "dark red"
    }

    var achievementRequiresWillpowerPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardEdictWritSealPlusPlusText: String {
        switch category {
        case .mastery: return "Edict Writ Seal Ultra of the Ascendant"
        case .streak: return "Edict Writ Seal Ultra of the Harbinger"
        case .score: return "Edict Writ Seal Ultra of the Destroyer"
        case .games: return "Edict Writ Seal Ultra of the Aspirant"
        }
    }

    var achievementCardProustitePlusStyle: String {
        isRareAchievement ? "scarlet adamantine" : "dull scarlet"
    }

    var achievementHegemonyPlusThreshold: Int {
        switch category {
        case .mastery: return 1000000
        case .streak: return 400000
        case .score: return 800000
        case .games: return 100000
        }
    }

    var achievementCardMiargyriteStyle: String {
        isRareAchievement ? "steel grey striated" : "dark pewter"
    }

    var achievementRequiresDrivePlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardCovenantWritSealUltraText: String {
        switch category {
        case .mastery: return "Covenant Writ Seal Ultra of the Immortal"
        case .streak: return "Covenant Writ Seal Ultra of the Arbiter"
        case .score: return "Covenant Writ Seal Ultra of the Paragon"
        case .games: return "Covenant Writ Seal Ultra of the Initiate"
        }
    }

    var achievementCardSamsoniteStyle: String {
        isRareAchievement ? "steel black monoclinic" : "gunmetal"
    }

    var achievementImperiumPlusThreshold: Int {
        switch category {
        case .mastery: return 1500000
        case .streak: return 600000
        case .score: return 1200000
        case .games: return 150000
        }
    }

    var achievementCardMatilditeStyle: String {
        isRareAchievement ? "iron grey trigonal" : "dull iron"
    }

    var achievementRequiresInitiativePlus: Bool {
        category == .mastery || category == .score
    }

    var achievementCardCharterWritSealUltraText: String {
        switch category {
        case .mastery: return "Charter Writ Seal Ultra of the Eternal"
        case .streak: return "Charter Writ Seal Ultra of the Aegis"
        case .score: return "Charter Writ Seal Ultra of the Titan"
        case .games: return "Charter Writ Seal Ultra of the Disciple"
        }
    }

    var achievementCardEmplectiteStyle: String {
        isRareAchievement ? "tin white prismatic" : "grey tin"
    }

    var achievementPantheonPlusThreshold: Int {
        switch category {
        case .mastery: return 2000000
        case .streak: return 800000
        case .score: return 1800000
        case .games: return 200000
        }
    }

    var achievementCardAikiniteStyle: String {
        isRareAchievement ? "blackish lead acicular" : "dark grey"
    }

    var achievementRequiresDevotionPlus: Bool {
        category == .streak || category == .games
    }

    var achievementCardAccordWritSealUltraText: String {
        switch category {
        case .mastery: return "Accord Writ Seal Ultra of the Celestial"
        case .streak: return "Accord Writ Seal Ultra of the Bastion"
        case .score: return "Accord Writ Seal Ultra of the Apex"
        case .games: return "Accord Writ Seal Ultra of the Seeker"
        }
    }

    var achievementCardWitticheniteStyle: String {
        isRareAchievement ? "steel grey orthorhombic" : "slate grey"
    }

    var achievementEternityPlusThreshold: Int {
        switch category {
        case .mastery: return 3000000
        case .streak: return 1200000
        case .score: return 2500000
        case .games: return 300000
        }
    }

    var achievementCardChalcostibiteStyle: String {
        isRareAchievement ? "lead grey prismatic" : "flat lead"
    }

    var achievementRequiresPersistencePlus: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardMandateWritSealUltraText: String {
        switch category {
        case .mastery: return "Mandate Writ Seal Ultra of the Divine"
        case .streak: return "Mandate Writ Seal Ultra of the Sentinel"
        case .score: return "Mandate Writ Seal Ultra of the Zenith"
        case .games: return "Mandate Writ Seal Ultra of the Pilgrim"
        }
    }

    var achievementCardCuprobismutiteStyle: String {
        isRareAchievement ? "silver grey tabular" : "tarnished silver"
    }

    var achievementInfinityPlusThreshold: Int {
        switch category {
        case .mastery: return 5000000
        case .streak: return 2000000
        case .score: return 4000000
        case .games: return 500000
        }
    }

    var achievementCardBerryiteStyle: String {
        isRareAchievement ? "steel blue metallic" : "dull blue grey"
    }

    var achievementRequiresStaminaPlus: Bool {
        category == .score || category == .mastery
    }

    var achievementCardStatuteWritSealUltraText: String {
        switch category {
        case .mastery: return "Statute Writ Seal Ultra of the Almighty"
        case .streak: return "Statute Writ Seal Ultra of the Overseer"
        case .score: return "Statute Writ Seal Ultra of the Sovereign"
        case .games: return "Statute Writ Seal Ultra of the Recruit"
        }
    }

    var achievementCardLindstromiteStyle: String {
        isRareAchievement ? "lead grey monoclinic" : "ashen grey"
    }

    var achievementApotheosisPlusThreshold: Int {
        switch category {
        case .mastery: return 7500000
        case .streak: return 3000000
        case .score: return 7000000
        case .games: return 750000
        }
    }
}
