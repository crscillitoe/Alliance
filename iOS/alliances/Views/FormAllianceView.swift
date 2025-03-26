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
    @State private var allianceName: String = ""

    var primaryButtonColor: Color = Color(
        red: 230 / 255,
        green: 100 / 255,
        blue: 149 / 255
    )

    var body: some View {
        VStack {
            TextField("Name your alliance", text: $allianceName)
                .padding()
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: primaryButtonColor.opacity(0.2), radius: 10, x: 0, y: -5)
                .shadow(color: .blue.opacity(0.2), radius: 10, x: 0, y: 5)
                .accentColor(.white)
                .frame(maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    primaryButtonColor.opacity(0.5),
                                    Color.blue.opacity(0.5),
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1)
                )
                .overlay(
                    Text("Name your alliance")
                        .foregroundColor(.gray)
                        .opacity(allianceName.isEmpty ? 1 : 0)
                        .padding(.horizontal, 15),
                    alignment: .leading
                )
                .onSubmit {
                    formAlliance()
                }
            Button(action: {
                formAlliance()
            }) {
                Text("Form Alliance")
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

    private func formAlliance() {
        Task {
            do {
                try await FormAllianceController.formAlliance(
                    allianceName: allianceName,
                    allianceIdentifierModel: allianceIdentifierModel)
                //dismiss()
            } catch {
                print("Error:", error)
            }
        }
    }
}

#Preview {
    FormAllianceView()
        .environmentObject(AllianceIdentifierModel())
}
