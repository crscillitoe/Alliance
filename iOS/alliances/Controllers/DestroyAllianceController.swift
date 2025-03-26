//
//  DestroyAllianceController.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/25/25.
//
import Foundation

class DestroyAllianceController {
    static func destroyAlliance(destroyMessage: String, allianceIdentifierModel: AllianceIdentifierModel) async throws {
        guard let allianceId = allianceIdentifierModel.allianceId else {
            return;
        }
        
        _ = try await AllianceService().destroyAlliance(allianceId: allianceId, message: destroyMessage)
        allianceIdentifierModel.clearAlliance()
    }
}
