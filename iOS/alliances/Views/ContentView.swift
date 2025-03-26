//
//  ContentView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel
    @State private var isModelLoaded = false

    var body: some View {
        ZStack {
            // This ensures the two views are stacked on top of each other, allowing transitions
            if allianceIdentifierModel.allianceId == nil {
                NoAllianceHomeView()
                    .transition(.move(edge: .leading))
            } else {
                InAllianceHomeView()
                    .transition(.move(edge: .trailing))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                allianceIdentifierModel.loadAlliance()
                isModelLoaded = true
            }
        }
        .animation(
            isModelLoaded ? .easeInOut : .none,
            value: allianceIdentifierModel.allianceId
        )
    }
}

#Preview {
    ContentView()
        .environmentObject(AllianceIdentifierModel())
}
