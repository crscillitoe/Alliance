//
//  NoAllianceHomeView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import SwiftUI

struct NoAllianceHomeView: View {
    @State private var isFormAlliancePresented = false

    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel

    var buttonColor: Color = Color(
        red: 60 / 255,
        green: 60 / 255,
        blue: 60 / 255
    )
    var primaryButtonColor: Color = Color(
        red: 230 / 255,
        green: 100 / 255,
        blue: 149 / 255
    )

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: FormAllianceView()) {
                    Text("Form Alliance")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 200)
                        .background(primaryButtonColor)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                NavigationLink(destination: JoinAllianceView()) {
                    Text("Join Alliance")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 200)
                        .background(buttonColor)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                .padding()
            }
            .padding()
            .containerRelativeFrame([.horizontal, .vertical])
            .background(.black)
        }
    }
}

#Preview {
    NoAllianceHomeView()
        .environmentObject(AllianceIdentifierModel())
}
