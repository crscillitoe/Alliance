//
//  InAllianceHomeView.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/24/25.
//

import SwiftUI

struct InAllianceHomeView: View {
    @State var allianceSize: Int?
    @State var isLoading = true
    @State var destroying = false

    @EnvironmentObject var allianceIdentifierModel: AllianceIdentifierModel

    var body: some View {
        NavigationStack {
            VStack {
                if !isLoading {
                    let allianceSize = self.allianceSize ?? 0
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
            .onAppear {
                if allianceSize == nil {
                    fetchAlliance()
                }
            }
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

    private func fetchAlliance() {
        Task {
            do {
                let alliance = try await FetchAllianceController.fetchAlliance(
                    allianceIdentifierModel: allianceIdentifierModel)
                allianceSize = alliance.size
                isLoading = false
            } catch {
                print("Error:", error)
            }
        }
    }
}

#Preview {
    InAllianceHomeView(allianceSize: 1, isLoading: false)
        .environmentObject(
            AllianceIdentifierModel(
                allianceId: "cd3645ef-a3d3-42e9-84a2-47d96cb81845",
                allianceName: "Test Alliance"))
}
