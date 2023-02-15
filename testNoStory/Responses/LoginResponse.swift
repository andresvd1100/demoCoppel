//
//  LoginResponse.swift
//  testNoStory
//
//  Created by Andres Valerio on 12/02/23.
//

import Foundation

struct LoginResponse: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
    let statusMessage: String?
    
    private enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case statusMessage = "status_message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt) ?? ""
        requestToken = try values.decodeIfPresent(String.self, forKey: .requestToken) ?? "no_access"
        statusMessage = try values.decodeIfPresent(String.self, forKey: .statusMessage)
    }
}
