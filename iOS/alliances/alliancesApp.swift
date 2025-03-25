//
//  alliancesApp.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI

@main
struct alliancesApp: App {
    @StateObject private var allianceIdentifierModel = AllianceIdentifierModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(allianceIdentifierModel)
        }
    }

}
