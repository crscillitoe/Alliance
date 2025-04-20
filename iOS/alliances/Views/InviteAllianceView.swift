//
//  InviteAllianceView.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/20/25.
//

import SwiftUI

struct InviteAllianceView: View {
    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel
    
    var body: some View {
        ZStack {
            QRCodeView(
                allianceId: allianceIdentifierModel.allianceId ?? "nil", allianceName: allianceIdentifierModel.allianceName ?? "nil",
                size: 200
            )
        }
        .foregroundColor(.white)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.black)
    }
}

#Preview {
    InviteAllianceView()
        .environmentObject(
            AllianceIdentifierModel(
                allianceId: "cd3645ef-a3d3-42e9-84a2-47d96cb81845",
                allianceName: "Test Alliance",
                allianceSize: 100
            )
        )
}
