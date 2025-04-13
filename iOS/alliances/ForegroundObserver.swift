//
//  ForegroundObserver.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/26/25.
//

import SwiftUI
import UIKit
import Logging

class ForegroundObserver: ObservableObject {
    @ObservedObject var allianceIdentifierModel: AllianceIdentifierModel
    let log = Logger(label: "ForegroundObserver")
    
    init(allianceIdentifierModel: AllianceIdentifierModel) {
        self.allianceIdentifierModel = allianceIdentifierModel
        NotificationCenter.default.addObserver(
            self, selector: #selector(appDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc func appDidBecomeActive() {
        log.debug("App did become foregrounded")
        
        if allianceIdentifierModel.allianceId != nil {
            DispatchQueue.main.async {
                Task {
                    _ = try await FetchAllianceController.fetchAlliance(allianceIdentifierModel: self.allianceIdentifierModel)
                }
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
