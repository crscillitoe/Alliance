//
//  AllianceService.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//
import Foundation

struct FetchSizeRequest: Codable {
    let passphrase: String
}

struct DestroyAllianceRequest: Codable {
    let passphrase: String
}

class AllianceService {
    let baseURL = "https://alliance-api.woohooj.in"

    func formAlliance() async throws -> String {
        guard let url = URL(string: "\(baseURL)/form_alliance") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "Invalid data", code: 0, userInfo: nil)
        }
        return responseString
    }

    func fetchAllianceSize(allianceId: String) async throws -> Int {
        guard let url = URL(string: "\(baseURL)/get_alliance_size") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = FetchSizeRequest(passphrase: allianceId)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NSError(domain: "Failed to fetch alliance size", code: 0, userInfo: nil)
        }
        
        guard let allianceSize = try? JSONDecoder().decode(Int.self, from: data) else {
            throw NSError(domain: "Invalid alliance size returned", code: 0, userInfo: nil)
        }
        return allianceSize
    }
    
    func destroyAlliance(allianceId: String) async throws -> Bool {
        guard let url = URL(string: "\(baseURL)/destroy_alliance") else {
            return false
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = FetchSizeRequest(passphrase: allianceId)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(requestBody)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        return httpResponse.statusCode == 200
    }
}
