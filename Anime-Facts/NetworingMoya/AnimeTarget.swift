//
//  AnimeTarget.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation
import Moya

/**
 * AnimeServices defines all the API endpoints for anime-related operations.
 * This enum conforms to TargetType to work with Moya networking library.
 */
enum AnimeServices {
    /// Fetch anime list for a specific year and season
    /// - Parameters:
    ///   - String: The year (e.g., "2022")
    ///   - Season: The season enum value (winter, spring, summer, fall)
    case readAnimes(String, Season)
}

// MARK: - TargetType Implementation
extension AnimeServices: TargetType {
    
    /// The base URL for all anime API endpoints
    var baseURL: URL {
        guard let url = URL(string: "https://jikan1.p.rapidapi.com") else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    /// The specific path for each API endpoint
    var path: String {
        switch self {
        case .readAnimes(let year, let season):
            return "/season/\(year)/\(season.rawValue)"
        }
    }
    
    /// HTTP method for the request
    var method: Moya.Method {
        switch self {
        case .readAnimes:
            return .get
        }
    }
    
    /// Request task configuration
    var task: Task {
        switch self {
        case .readAnimes:
            return .requestPlain
        }
    }
    
    /// HTTP headers for the request
    /// TODO: Move API key to a secure configuration file or environment variable
    var headers: [String : String]? {
        return [
            "X-RapidAPI-Key": APIConfiguration.rapidAPIKey,
            "X-RapidAPI-Host": "jikan1.p.rapidapi.com",
            "Content-Type": "application/json"
        ]
    }
}

// MARK: - API Configuration
/**
 * APIConfiguration handles API-related configuration.
 * This should be moved to a secure configuration system in production.
 */
private struct APIConfiguration {
    /// RapidAPI key for accessing the Jikan API
    /// In production, this should be loaded from a secure configuration file
    /// or environment variable, not hardcoded in the source code
    static let rapidAPIKey = "89ef938d70mshd46bc5e45e06c13p1cae7fjsnc445e85c6b24"
    
    /// Base host for the API
    static let apiHost = "jikan1.p.rapidapi.com"
    
    /// API version (if needed for future versioning)
    static let apiVersion = "v1"
}

