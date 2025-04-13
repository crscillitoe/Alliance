//
//  AllianceDestroyedHomeView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/26/25.
//

import SwiftUI

struct DestroyedAllianceHomeView: View {
    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel
    
    var body: some View {
        let destroyedMessage = allianceIdentifierModel.destroyedMessage ?? "No message provided."
        
        VStack {
            Text("Your Alliance has been destroyed.")
                .font(.title)
                .foregroundColor(.red)
                .padding(.vertical, 50)
                .frame(width: 300, alignment: .center)
                .multilineTextAlignment(.center)
            Text("A message from the traitor")
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 300, alignment: .center)
                .padding(.bottom, 50)
            Text("\(destroyedMessage)")
                .font(.body)
                .foregroundColor(.white)
                .frame(width: 300, alignment: .center)
            Spacer()
            Button(action: {
                allianceIdentifierModel.clearAlliance()
            }) {
                Text("Acknowledge")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 200)
                    .background(.red)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
            .padding(.bottom, 50)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.black)
    }
}

#Preview {
    DestroyedAllianceHomeView()
    .environmentObject(AllianceIdentifierModel(
        destroyedMessage: "This is your destroyed message. It should be long; multi-sentence. It should be evil too."
    ))
}
