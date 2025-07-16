//
//  AnimeProvider.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import RxSwift
import Moya

/**
 * AnimeNetwork protocol defines the contract for anime network operations.
 * This protocol abstracts the network layer implementation, making it testable and flexible.
 */
protocol AnimeNetwork {
    /// Fetches anime list for a specific year and season
    /// - Parameters:
    ///   - year: The year as a string (e.g., "2022")
    ///   - season: The season enum value
    /// - Returns: A Single observable containing the anime request response
    func fetchAnime(year: String, season: Season) -> Single<AnimeRequest>
}

/**
 * AnimeNetworkImplementation provides concrete implementation of AnimeNetwork protocol.
 * This class handles all anime-related network operations using Moya.
 */
class AnimeNetworkImplementation: AnimeNetwork {
    
    // MARK: - Properties
    
    /// Moya provider for handling network requests
    private let provider: MoyaProvider<AnimeServices>
    
    // MARK: - Initialization
    
    /// Initializes the network implementation with a Moya provider
    /// - Parameter provider: The Moya provider instance (defaults to standard provider)
    init(provider: MoyaProvider<AnimeServices> = MoyaProvider<AnimeServices>()) {
        self.provider = provider
    }
    
    // MARK: - AnimeNetwork Implementation
    
    /// Fetches anime list for a specific year and season
    /// - Parameters:
    ///   - year: The year as a string (e.g., "2022")
    ///   - season: The season enum value
    /// - Returns: A Single observable containing the anime request response
    func fetchAnime(year: String, season: Season) -> Single<AnimeRequest> {
        return provider.rx
            .request(.readAnimes(year, season))
            .filterSuccessfulStatusCodes()
            .map(AnimeRequest.self)
            .do(onSuccess: { response in
                print("✅ Successfully fetched \(response.anime.count) anime for \(season.rawValue) \(year)")
            }, onError: { error in
                print("❌ Failed to fetch anime: \(error.localizedDescription)")
            })
    }
}

// MARK: - Error Handling Extensions

/**
 * Custom error types for better error handling
 */
enum AnimeNetworkError: Error, LocalizedError {
    case invalidYear
    case noDataAvailable
    case apiKeyMissing
    case networkTimeout
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidYear:
            return "Invalid year format provided"
        case .noDataAvailable:
            return "No anime data available for the specified season and year"
        case .apiKeyMissing:
            return "API key is missing or invalid"
        case .networkTimeout:
            return "Request timed out. Please check your connection and try again"
        case .decodingError:
            return "Failed to decode response data"
        }
    }
}
