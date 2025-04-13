//
//  ContentView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel
    
    @State private var initialLoad = true;
    
    var body: some View {
        ZStack {
            if allianceIdentifierModel.allianceId == nil {
                NoAllianceHomeView()
                    .transition(.move(edge: .leading))
            } else if allianceIdentifierModel.destroyedMessage != nil {
                DestroyedAllianceHomeView()
                    .transition(
                        allianceIdentifierModel.allianceId == nil ?
                            .move(edge: .leading) :
                                .move(edge: .trailing)
                    )
            } else  {
                InAllianceHomeView()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(
            initialLoad ? .easeInOut : .none,
            value: allianceIdentifierModel.allianceId
        )
        .animation(
            initialLoad ? .easeInOut : .none,
            value: allianceIdentifierModel.destroyedMessage
        )
        .onAppear {
            initialLoad = false;
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(AllianceIdentifierModel())
}
