//
//  AllianceService.swift
//  alliances
//
//  Created by Bradford Bonanno on 3/23/25.
//
import Foundation
import Logging

struct FetchAllianceRequest: Codable {
    let passphrase: String
}

struct Alliance: Codable {
    let destroyed: String?
    let name: String
    let size: Int
}

struct DestroyAllianceRequest: Codable {
    let passphrase: String
    let message: String
}

struct FormAllianceRequest: Codable {
    let name: String
}

class AllianceService {
    let baseURL = "https://alliance-api.woohooj.in"
    let log = Logger(label: "AllianceService")

    func formAlliance(allianceName: String) async throws -> String {
        guard let url = URL(string: "\(baseURL)/form_alliance") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = FormAllianceRequest(name: allianceName)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(requestBody)

        let (data, _) = try await URLSession.shared.data(for: request)
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "Invalid data", code: 0, userInfo: nil)
        }
        return responseString
    }

    func fetchAlliance(allianceId: String) async throws -> Alliance {
        log.debug("Fetching alliance: \(allianceId)")
        guard let url = URL(string: "\(baseURL)/get_alliance") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = FetchAllianceRequest(passphrase: allianceId)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(requestBody)

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode != 200
        {
            throw NSError(
                domain: "Failed to fetch alliance", code: httpResponse.statusCode, userInfo: nil)
        }
        
        guard
            let alliance = try? JSONDecoder().decode(Alliance.self, from: data)
        else {
            throw NSError(
                domain: "Invalid alliance returned", code: 0, userInfo: nil
            )
        }
        return alliance
    }

    func destroyAlliance(allianceId: String, message: String) async throws -> Bool {
        guard let url = URL(string: "\(baseURL)/destroy_alliance") else {
            return false
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = DestroyAllianceRequest(
            passphrase: allianceId, message: message)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(requestBody)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        return httpResponse.statusCode == 200
    }
}
