//
//  ForegroundObserver.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/26/25.
//

import SwiftUI
import UIKit
import Logging
import Combine


class ForegroundObserver: ObservableObject {
    @ObservedObject var allianceIdentifierModel: AllianceIdentifierModel
    @Published var freshData = false
    private var cancellables = Set<AnyCancellable>()

    let log = Logger(label: "ForegroundObserver")
    
    init(allianceIdentifierModel: AllianceIdentifierModel) {
        self.allianceIdentifierModel = allianceIdentifierModel
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in self?.appDidBecomeActive() }
            .store(in: &cancellables)
    }

    func appDidBecomeActive() {
        log.debug("App did become foregrounded")
        DispatchQueue.main.async {
            Task {
                _ = try await FetchAllianceController.fetchAlliance(allianceIdentifierModel: self.allianceIdentifierModel)
                self.freshData = true
            }
        }
    }
    
    func refreshDataOnNextLaunch() {
        log.debug("Will refresh data on next launch")
        DispatchQueue.main.async {
            Task {
                self.freshData = false
            }
        }
    }
}
