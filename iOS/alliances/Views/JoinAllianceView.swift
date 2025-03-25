//
//  JoinAllianceView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI

struct JoinAllianceView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text(
                "TODO: Pop camera"
            )
            .foregroundColor(.white)
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
}
