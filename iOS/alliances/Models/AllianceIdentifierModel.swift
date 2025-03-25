//
//  AllianceIdentifierModel.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import SwiftUI

class AllianceIdentifierModel: ObservableObject {
    @Published var allianceId: String? = nil

    init() {
        loadAllianceID()
    }
    
    init(allianceId: String) {
        self.allianceId = allianceId
    }

    func loadAllianceID() {
        DispatchQueue.main.async {
            if let savedAllianceId = UserDefaults.standard.string(
                forKey: "allianceId")
            {
                print("Loaded \(savedAllianceId) from UserDefaults")
                self.allianceId = savedAllianceId
            }
        }
    }

    func saveAllianceID(_ allianceId: String) {
        DispatchQueue.main.async {
            UserDefaults.standard.set(allianceId, forKey: "allianceId")
            self.allianceId = allianceId
        }
    }

    func clearAllianceID() {
        DispatchQueue.main.async {
            UserDefaults.standard.removeObject(forKey: "allianceId")
            self.allianceId = nil
        }
    }
}
