//
//  FormAllianceController.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import Foundation
import Logging

class FetchAllianceController {
    static let log = Logger(label: "FetchAllianceController")

    static func fetchAlliance(allianceIdentifierModel: AllianceIdentifierModel) async throws -> Void {
        log.debug("Starting fetch alliance process")
        await allianceIdentifierModel.loadAllianceFromCache()
        guard let allianceId = allianceIdentifierModel.allianceId else {
            return;
        }
        let alliance = try await AllianceService().fetchAlliance(allianceId: allianceId)
        allianceIdentifierModel.publishAlliance(alliance: alliance)
    }
}
