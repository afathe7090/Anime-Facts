//
//  AnimeRepo.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import RxSwift

/**
 * AnimeRepo defines the contract for anime data access operations.
 * This protocol abstracts the data source implementation, enabling clean separation
 * between domain and data layers following the Repository pattern.
 */
protocol AnimeRepo: AnyObject {
    
    /// Fetches anime list for a specific year and season
    /// - Parameters:
    ///   - year: The year as a string (e.g., "2022")
    ///   - season: The season for which to fetch anime
    /// - Returns: A Single observable containing the anime request response
    func animes(year: String, season: Season) -> Single<AnimeRequest>
    
    /// Fetches anime for the current season and year
    /// - Returns: A Single observable containing the anime request response
    func currentSeasonAnimes() -> Single<AnimeRequest>
    
    /// Validates if a year string is valid for API requests
    /// - Parameter year: The year string to validate
    /// - Returns: Boolean indicating if the year is valid
    func isValidYear(_ year: String) -> Bool
}
