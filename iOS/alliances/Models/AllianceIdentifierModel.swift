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

    init() {
        clearAlliance()
        loadAlliance()
    }
    
    init(allianceId: String, allianceName: String) {
        self.allianceId = allianceId
        self.allianceName = allianceName
    }

    func loadAlliance() {
        DispatchQueue.main.async {
            if let savedAllianceId = UserDefaults.standard.string(
                forKey: "allianceId")
            {
                print("Loaded \(savedAllianceId) from UserDefaults")
                self.allianceId = savedAllianceId
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
        }
    }
}
