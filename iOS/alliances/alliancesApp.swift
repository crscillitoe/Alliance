//
//  alliancesApp.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI
import Logging

@main
struct alliancesApp: App {
    @StateObject private var allianceIdentifierModel: AllianceIdentifierModel
    @StateObject private var foregroundObserver: ForegroundObserver
    

    init() {
        alliancesApp.setupLogging()
        let identifierModel = AllianceIdentifierModel()
        _allianceIdentifierModel = StateObject(wrappedValue: identifierModel)

        let observer = ForegroundObserver(
            allianceIdentifierModel: identifierModel)
        _foregroundObserver = StateObject(wrappedValue: observer)
    }
    
    static func setupLogging() {
        LoggingSystem.bootstrap { label in
            LogLevelHandler(label: label)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(allianceIdentifierModel)
        }
    }

}
