//
//  AllianceIdentifierModel.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import SwiftUI

class AllianceIdentifierModel: ObservableObject {
    @Published var allianceId: String? = nil
    @Published var allianceName: String? = nil
    @Published var destroyedMessage: String? = nil

    init() {
        loadAlliance()
    }
    
    init(allianceId: String? = nil, allianceName: String? = nil, destroyedMessage: String? = nil) {
        self.allianceId = allianceId
        self.allianceName = allianceName
        self.destroyedMessage = destroyedMessage
    }

    func loadAlliance() {
        DispatchQueue.main.async {
            if let savedAllianceId = UserDefaults.standard.string(
                forKey: "allianceId")
            {
                print("Loaded \(savedAllianceId) from UserDefaults")
                self.allianceId = savedAllianceId
                
                Task {
                    _ = try await FetchAllianceController.fetchAlliance(allianceIdentifierModel: self)
                }
            }
            
            if let savedAllianceName = UserDefaults.standard.string(forKey: "allianceName") {
                self.allianceName = savedAllianceName
            }
        }
    }

    func saveAllianceID(_ allianceId: String) {
        DispatchQueue.main.async {
            UserDefaults.standard.set(allianceId, forKey: "allianceId")
            self.allianceId = allianceId
        }
    }
    
    func saveAllianceName(allianceName: String) {
        DispatchQueue.main.async {
            UserDefaults.standard.set(allianceName, forKey: "allianceName")
            self.allianceName = allianceName
        }
    }

    func clearAlliance() {
        DispatchQueue.main.async {
            UserDefaults.standard.removeObject(forKey: "allianceId")
            UserDefaults.standard.removeObject(forKey: "allianceName")
            self.allianceId = nil
            self.allianceName = nil
            self.destroyedMessage = nil
        }
    }
    
    func publishDestroyedMessage(message: String?) {
        DispatchQueue.main.async {
            self.destroyedMessage = message
        }
    }
}
