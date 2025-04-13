//
//  AllianceIdentifierModel.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import SwiftUI
import Logging

class AllianceIdentifierModel: ObservableObject {
    @Published var allianceId: String? = nil
    @Published var allianceName: String? = nil
    @Published var destroyedMessage: String? = nil
    @Published var allianceSize: Int? = nil
    
    let log = Logger(label: "AllianceIdentifierModel")
    
    init(allianceId: String? = nil, allianceName: String? = nil, destroyedMessage: String? = nil, allianceSize: Int? = nil) {
        self.allianceId = allianceId
        self.allianceName = allianceName
        self.destroyedMessage = destroyedMessage
        self.allianceSize = allianceSize
    }

    func loadAllianceFromCache() async -> Void {
        if self.allianceId != nil { return }
        if let savedAllianceId = UserDefaults.standard.string(
            forKey: "allianceId")
        {
            self.log.debug("Loaded ID \(savedAllianceId) from UserDefaults")
            await MainActor.run {
                self.allianceId = savedAllianceId
            }
        }
        
        if let savedAllianceName = UserDefaults.standard.string(forKey: "allianceName") {
            self.log.debug("Loaded name \(savedAllianceName) from UserDefaults")
            await MainActor.run {
                self.allianceName = savedAllianceName
            }
        }
    }

    func saveAllianceID(_ allianceId: String) {
        DispatchQueue.main.async {
            self.log.debug("Saving alliance ID: \(allianceId)")
            UserDefaults.standard.set(allianceId, forKey: "allianceId")
            self.allianceId = allianceId
        }
    }

    func clearAlliance() {
        DispatchQueue.main.async {
            UserDefaults.standard.removeObject(forKey: "allianceId")
            UserDefaults.standard.removeObject(forKey: "allianceName")
            self.allianceId = nil
            self.allianceName = nil
            self.destroyedMessage = nil
            self.allianceSize = nil
        }
    }
    
    func publishAlliance(alliance: Alliance) {
        DispatchQueue.main.async {
            UserDefaults.standard.set(alliance.name, forKey: "allianceName")
            self.allianceName = alliance.name
            self.allianceSize = alliance.size
            self.destroyedMessage = alliance.destroyed
        }
    }
}
