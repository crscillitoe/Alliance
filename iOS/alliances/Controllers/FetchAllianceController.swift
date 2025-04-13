//
//  FormAllianceController.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import Foundation
import Logging

let log = Logger(label: "FetchAllianceController")

class FetchAllianceController {
    static func fetchAlliance(allianceIdentifierModel: AllianceIdentifierModel) async throws -> Alliance {
        log.debug("Starting fetch alliance process")
        await allianceIdentifierModel.loadAllianceFromCache()
        guard let allianceId = allianceIdentifierModel.allianceId else {
            throw NSError(domain: "Cannot fetch alliance without an ID", code: 1001, userInfo: nil)
        }
        let alliance = try await AllianceService().fetchAlliance(allianceId: allianceId)
        allianceIdentifierModel.publishAlliance(alliance: alliance)
        return alliance
    }
}
