//
//  FormAllianceView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI

struct FormAllianceView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel


    var body: some View {
        VStack {
            Text(
                "TODO: Name alliance, generate key"
            )
            .foregroundColor(.white)
            Text(
                "Alliance ID: \(String(describing: allianceIdentifierModel.allianceId))"
            )
            .foregroundColor(.white)
            .font(.caption)
            .padding()
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.body)
                        .foregroundColor(.white)
                }
            })

    }
}

#Preview {
    FormAllianceView()
        .environmentObject(AllianceIdentifierModel())
}
