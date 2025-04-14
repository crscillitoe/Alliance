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
    @StateObject private var deepLinkManager = DeepLinkManager()

    @Environment(\.scenePhase) private var scenePhase
    
    private var log: Logger

    

    init() {
        alliancesApp.setupLogging()
        self.log = Logger(label: "alliancesApp")
        log.debug("Initializing App")
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
            if foregroundObserver.freshData {
                ContentView()
                    .environmentObject(allianceIdentifierModel)
                    .environmentObject(deepLinkManager)
                    .onChange(of: scenePhase) { oldValue, newValue in
                        if newValue == .background  && allianceIdentifierModel.allianceId != nil {
                            foregroundObserver.refreshDataOnNextLaunch()
                        }
                    }
                    .onOpenURL { url in
                        deepLinkManager.handleDeepLink(url: url)
                    }
            } else {
                ProgressView()
                    .progressViewStyle(
                        CircularProgressViewStyle(tint: .white)
                    )
                    .scaleEffect(2)
                    .containerRelativeFrame([.horizontal, .vertical])
                    .background(.black)
            }
            
        }
    }

}
