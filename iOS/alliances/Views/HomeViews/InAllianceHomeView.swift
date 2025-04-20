//
//  InAllianceHomeView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import SwiftUI
import Logging

struct InAllianceHomeView: View {
    @State var destroying = false

    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel
    
    let log = Logger(label: "InAllianceHomeView")

    var body: some View {
        NavigationStack {
            VStack {
                if allianceIdentifierModel.allianceId != nil {
                    let allianceSize = self.allianceIdentifierModel.allianceSize ?? 0
                    Text("Alliance Members")
                        .font(.headline)
                        .padding(.top, 70)
                        .foregroundColor(.gray)
                    Text("\(allianceSize)")
                        .font(.system(size: 120))
                        .padding()
                        .foregroundColor(.white)
                    Text("\(getDisplayName())")
                        .font(.body)
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        destroying = true
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
                    NavigationLink{
                        InviteAllianceView()
                    } label: {
                        Text("Invite")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 200)
                            .background(.gray)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    Spacer()
                } else {
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: .white)
                        )
                        .scaleEffect(2)
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(.black)
            .navigationDestination(isPresented: $destroying) {
                DestroyAllianceView()
            }
            .onChange(of: allianceIdentifierModel.allianceId) {
                if allianceIdentifierModel.allianceId != nil {
                    destroying = false
                }
            }
        }
    }

    private func getDisplayId() -> String {
        guard let allianceId = allianceIdentifierModel.allianceId else {
            return ""
        }
        return String(allianceId.split(separator: "-").last!)
    }

    private func getDisplayName() -> String {
        let defaultName = "Unknown"
        guard let name = allianceIdentifierModel.allianceName else {
            return defaultName
        }
        return name.isEmpty ? defaultName : name
    }
}

#Preview {
    InAllianceHomeView()
        .environmentObject(
            AllianceIdentifierModel(
                allianceId: "cd3645ef-a3d3-42e9-84a2-47d96cb81845",
                allianceName: "Test Alliance",
                allianceSize: 100
            ))
}
