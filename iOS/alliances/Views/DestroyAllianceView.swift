//
//  FormAllianceView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//

import SwiftUI

var primaryButtonColor: Color = Color(
    red: 230 / 255,
    green: 100 / 255,
    blue: 149 / 255
)

struct DestroyAllianceView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel
    @State private var message: String = ""
    @State private var showAlert = false

    var gradient = LinearGradient(
        gradient: Gradient(colors: [
            primaryButtonColor.opacity(0.5),
            Color.blue.opacity(0.5),
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var isSubmitDisabled: Bool {
        message.count < 10
    }

    var body: some View {
        VStack {
            TextField("Why destroy?", text: $message)
                .padding()
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .accentColor(.white)
                .shadow(
                    color: primaryButtonColor.opacity(0.2), radius: 10, x: 0,
                    y: -5
                )
                .shadow(color: .blue.opacity(0.2), radius: 10, x: 0, y: 5)
                .frame(maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            gradient,
                            lineWidth: 1)
                )
                .overlay(
                    Text("Why destroy?")
                        .foregroundColor(.gray)
                        .opacity(message.isEmpty ? 1 : 0)
                        .padding(.horizontal, 15),
                    alignment: .leading
                )
                .onSubmit {
                    if isSubmitDisabled {
                        return;
                    }
                    showAlert = true
                }
            Button(action: {
                showAlert = true
            }) {
                Text("Destroy Alliance")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 200)
                    .background(.red)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
            .padding(.top, 50)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text(
                        "Do you really want to destroy this alliance?"),
                    primaryButton: .destructive(Text("Destroy")) {
                        destroyAlliance()
                    },
                    secondaryButton: .cancel()
                )
            }
            .disabled(isSubmitDisabled)
            .opacity(isSubmitDisabled ? 0.5 : 1)
            .animation(.default, value: isSubmitDisabled)
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

    private func destroyAlliance() {
        Task {
            do {
                guard let allianceId = allianceIdentifierModel.allianceId else {
                    return
                }
                _ = try await DestroyAllianceController.destroyAlliance(destroyMessage: message, allianceIdentifierModel: allianceIdentifierModel)
            } catch {
                print("Error:", error)
            }
        }
    }
}

#Preview {
    DestroyAllianceView()
        .environmentObject(AllianceIdentifierModel())
}
