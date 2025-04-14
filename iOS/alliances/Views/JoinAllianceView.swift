//
//  JoinAllianceView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI
import Logging

struct JoinAllianceView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var deepLinkManager: DeepLinkManager
    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel

    var allianceId: String? = nil
    var allianceName: String? = nil
    
    let log = Logger(label: "JoinAllianceView")
    
    init(allianceId: String? = nil, allianceName: String? = nil) {
        self.allianceId = allianceId
        self.allianceName = allianceName
        log.debug("Joining alliance: \(allianceId ?? "Nil")")
    }
        
    var body: some View {

        VStack {
            if allianceId == nil {
                Text(
                    "TODO: Pop camera"
                )
                .foregroundColor(.white)
            } else {
                Text(
                    "Join \(allianceName ?? "Nil")?"
                )
                .foregroundColor(.white)
                
                Button(action: {
                    joinAlliance()
                }) {
                    Text("Join Alliance")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 200)
                        .background(primaryButtonColor)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                .padding(.top, 50)
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                deepLinkManager.publishStopNavigation()
                dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.body)
                        .foregroundColor(.white)
                }
            })

    }
    
    func joinAlliance() {
        Task {
            do {
                try await JoinAllianceController.joinAlliance(
                    allianceId: allianceId ?? "Nil",
                    allianceIdentifierModel: allianceIdentifierModel
                )
                deepLinkManager.publishStopNavigation()
            }
        }
    }
}

#Preview {
    JoinAllianceView(
        allianceId: "123",
        allianceName: "Test Alliance"
    )
    .environmentObject(AllianceIdentifierModel())
}
