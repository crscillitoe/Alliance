//
//  JoinAllianceController.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/13/25.
//

import Foundation
import Logging


class JoinAllianceController {
    static let log = Logger(label: "JoinAllianceController")
    
    static func joinAlliance(allianceId: String, allianceIdentifierModel: AllianceIdentifierModel) async throws -> Void {
        log.debug("Joining Alliance \(allianceId)")
         try await AllianceService().joinAlliance(allianceId: allianceId)
        allianceIdentifierModel.saveAllianceID(allianceId)
        _ = try await FetchAllianceController.fetchAlliance(allianceIdentifierModel: allianceIdentifierModel)
    }
}
