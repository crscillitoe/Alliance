//
//  alliancesApp.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI

@main
struct alliancesApp: App {
    @StateObject private var allianceIdentifierModel: AllianceIdentifierModel
    @StateObject private var foregroundObserver: ForegroundObserver

    init() {
        let identifierModel = AllianceIdentifierModel()
        _allianceIdentifierModel = StateObject(wrappedValue: identifierModel)

        let observer = ForegroundObserver(
            allianceIdentifierModel: identifierModel)
        _foregroundObserver = StateObject(wrappedValue: observer)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(allianceIdentifierModel)
        }
    }

}
