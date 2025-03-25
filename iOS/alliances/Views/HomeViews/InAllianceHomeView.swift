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
    @State private var showAlert = false

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

    private func destroyAlliance() {
        Task {
            do {
                isLoading = true
                guard let allianceId = allianceIdentifierModel.allianceId else {
                    return
                }

                let result = try await AllianceService().destroyAlliance(
                    allianceId: allianceId)

                if result {
                    allianceIdentifierModel.clearAlliance()
                }
            } catch {
                print("Error:", error)
                isLoading = false
            }
        }
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
