//
//  FormAllianceController.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import Foundation

class FormAllianceController {
    static func formAlliance(allianceName: String, allianceIdentifierModel: AllianceIdentifierModel) async throws {
        if allianceIdentifierModel.allianceId != nil {
            return
        }
        let allianceId = try await AllianceService().formAlliance(allianceName: allianceName)
        allianceIdentifierModel.saveAllianceID(allianceId)
    }
}
