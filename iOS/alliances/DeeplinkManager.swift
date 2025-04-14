//
//  DeeplinkManager.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/13/25.
//
import Foundation
import Logging

class DeepLinkManager: ObservableObject {
    @Published var allianceId: String? = nil
    @Published var allianceName: String? = nil
    @Published var shouldNavigateToJoinAllianceView = false
    
    let log = Logger(label: "DeepLinkManager")
    
    func handleDeepLink(url: URL) {
        log.debug("URL: \(url)")
        guard url.scheme == "alliances" else { return }
        guard url.host == "open" else { return }
        
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
           let queryItems = components.queryItems {
            guard let idItem = queryItems.first(where: { $0.name == "id" }) else {
                log.error("Failed to get ID item from query")
                return
            }
            allianceId = idItem.value
            
            guard let nameItem = queryItems.first(where: { $0.name == "name"}) else {
                log.error("Failed to get ID item from query")
                return
            }
            allianceName = nameItem.value
            shouldNavigateToJoinAllianceView = true
        }
    }
    
    func publishStopNavigation() {
        DispatchQueue.main.async {
            self.shouldNavigateToJoinAllianceView = false
        }
    }
}
