//
//  AnimeRepoImplementation.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import RxSwift
import Resolver

/**
 * AnimeRepoImplementation provides concrete implementation of the AnimeRepo protocol.
 * This class acts as a bridge between the domain layer and the network layer,
 * handling data transformation and error management.
 */
class AnimeRepoImplementation: AnimeRepo {
    
    // MARK: - Properties
    
    /// Network service for API calls
    @Injected private var network: AnimeNetwork
    
    /// Valid year range for API requests
    private let validYearRange = 1900...2030
    
    // MARK: - AnimeRepo Implementation
    
    /// Fetches anime list for a specific year and season
    /// - Parameters:
    ///   - year: The year as a string (e.g., "2022")
    ///   - season: The season for which to fetch anime
    /// - Returns: A Single observable containing the anime request response
    func animes(year: String, season: Season) -> Single<AnimeRequest> {
        // Validate year before making API call
        guard isValidYear(year) else {
            return Single.error(AnimeNetworkError.invalidYear)
        }
        
        return network.fetchAnime(year: year, season: season)
            .do(onSuccess: { response in
                print("📊 Repository: Fetched \(response.anime.count) anime for \(season.displayName) \(year)")
            })
            .catch { error in
                print("🔴 Repository Error: \(error.localizedDescription)")
                return Single.error(self.mapNetworkError(error))
            }
    }
    
    /// Fetches anime for the current season and year
    /// - Returns: A Single observable containing the anime request response
    func currentSeasonAnimes() -> Single<AnimeRequest> {
        let currentYear = String(Calendar.current.component(.year, from: Date()))
        let currentSeason = Season.current
        
        return animes(year: currentYear, season: currentSeason)
    }
    
    /// Validates if a year string is valid for API requests
    /// - Parameter year: The year string to validate
    /// - Returns: Boolean indicating if the year is valid
    func isValidYear(_ year: String) -> Bool {
        guard let yearInt = Int(year) else { return false }
        return validYearRange.contains(yearInt)
    }
    
    // MARK: - Private Helpers
    
    /// Maps network errors to domain-specific errors
    /// - Parameter error: The network error to map
    /// - Returns: A domain-specific error
    private func mapNetworkError(_ error: Error) -> Error {
        // Map specific network errors to domain errors
        if let networkError = error as? AnimeNetworkError {
            return networkError
        }
        
        // Default error mapping
        return AnimeNetworkError.networkTimeout
    }
}
