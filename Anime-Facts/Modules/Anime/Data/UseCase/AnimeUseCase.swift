//
//  AnimeUseCase.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation
import Resolver
import RxSwift

/**
 * AnimeUseCaseProtocol defines the contract for anime business logic operations.
 * This protocol encapsulates the business rules and use cases for anime-related functionality.
 */
protocol AnimeUseCaseProtocol {
    /// Fetches anime list for a specific year and season
    /// - Parameters:
    ///   - year: The year as a string
    ///   - season: The season for which to fetch anime
    /// - Returns: An Observable containing an array of anime objects
    func animes(year: String, season: Season) -> Observable<[Anime]>
    
    /// Fetches anime for the current season and year
    /// - Returns: An Observable containing an array of anime objects
    func currentSeasonAnimes() -> Observable<[Anime]>
    
    /// Filters anime by minimum member count
    /// - Parameters:
    ///   - animes: The anime array to filter
    ///   - minMembers: Minimum number of members required
    /// - Returns: Filtered array of anime
    func filterByPopularity(_ animes: [Anime], minMembers: Int) -> [Anime]
    
    /// Searches anime by title
    /// - Parameters:
    ///   - animes: The anime array to search
    ///   - query: The search query
    /// - Returns: Filtered array of anime matching the search
    func searchAnime(_ animes: [Anime], query: String) -> [Anime]
}

/**
 * AnimeUseCase provides concrete implementation of anime business logic.
 * This class handles data transformation, filtering, and business rules
 * while maintaining separation from UI and data layers.
 */
class AnimeUseCase: AnimeUseCaseProtocol {
    
    // MARK: - Properties
    
    /// Repository for data access
    @Injected var repo: AnimeRepo
    
    // MARK: - AnimeUseCaseProtocol Implementation
    
    /// Fetches anime list for a specific year and season
    /// - Parameters:
    ///   - year: The year as a string
    ///   - season: The season for which to fetch anime
    /// - Returns: An Observable containing an array of anime objects
    func animes(year: String, season: Season) -> Observable<[Anime]> {
        return repo.animes(year: year, season: season)
            .asObservable()
            .map { response in
                // Filter out invalid anime entries
                let validAnimes = response.anime.filter { $0.isValid }
                print("✅ UseCase: Processed \(validAnimes.count) valid anime out of \(response.anime.count)")
                return validAnimes
            }
            .do(onError: { error in
                print("❌ UseCase Error: \(error.localizedDescription)")
            })
    }
    
    /// Fetches anime for the current season and year
    /// - Returns: An Observable containing an array of anime objects
    func currentSeasonAnimes() -> Observable<[Anime]> {
        return repo.currentSeasonAnimes()
            .asObservable()
            .map { response in
                let validAnimes = response.anime.filter { $0.isValid }
                print("✅ UseCase: Fetched \(validAnimes.count) current season anime")
                return validAnimes
            }
    }
    
    /// Filters anime by minimum member count
    /// - Parameters:
    ///   - animes: The anime array to filter
    ///   - minMembers: Minimum number of members required
    /// - Returns: Filtered array of anime
    func filterByPopularity(_ animes: [Anime], minMembers: Int) -> [Anime] {
        return animes.filter { $0.members >= minMembers }
    }
    
    /// Searches anime by title
    /// - Parameters:
    ///   - animes: The anime array to search
    ///   - query: The search query
    /// - Returns: Filtered array of anime matching the search
    func searchAnime(_ animes: [Anime], query: String) -> [Anime] {
        guard !query.isEmpty else { return animes }
        
        let lowercaseQuery = query.lowercased()
        return animes.filter { anime in
            anime.title.lowercased().contains(lowercaseQuery) ||
            anime.synopsis.lowercased().contains(lowercaseQuery)
        }
    }
}
