//
//  Anime.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation

// MARK: - API Response Models

/**
 * AnimeRequest represents the top-level response from the anime API.
 * This model contains an array of anime objects for a specific season and year.
 */
struct AnimeRequest: Codable {
    /// Array of anime objects returned from the API
    let anime: [Anime]
    
    /// Custom keys for JSON decoding if needed
    enum CodingKeys: String, CodingKey {
        case anime = "data" // In case API returns 'data' instead of 'anime'
    }
}

// MARK: - Core Data Models

/**
 * Anime represents a single anime entry with all its properties.
 * This model follows the structure of the Jikan API response.
 */
struct Anime: Codable {
    /// MyAnimeList ID - unique identifier for the anime
    let malId: Int
    
    /// Direct URL to the anime page on MyAnimeList
    let url: String
    
    /// Official title of the anime
    let title: String
    
    /// URL to the anime's poster/cover image
    let imageUrl: String
    
    /// Brief description/summary of the anime plot
    let synopsis: String
    
    /// Number of episodes (nil if unknown or ongoing)
    let episodes: Int?
    
    /// Number of MyAnimeList members who have this anime in their list
    let members: Int
    
    /// Custom keys for JSON decoding to match API response
    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case url
        case title
        case imageUrl = "image_url"
        case synopsis
        case episodes
        case members
    }
}

// MARK: - Anime Extensions

extension Anime {
    /// Computed property to get a safe synopsis text
    var safeSynopsis: String {
        return synopsis.isEmpty ? "No synopsis available" : synopsis
    }
    
    /// Computed property to get formatted episode count
    var episodeCountText: String {
        guard let episodes = episodes else {
            return "Episodes: Unknown"
        }
        return episodes == 1 ? "1 Episode" : "\(episodes) Episodes"
    }
    
    /// Computed property to get formatted member count
    var memberCountText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedNumber = formatter.string(from: NSNumber(value: members)) ?? "\(members)"
        return "\(formattedNumber) members"
    }
    
    /// Validates if the anime has all required information
    var isValid: Bool {
        return !title.isEmpty && !imageUrl.isEmpty && malId > 0
    }
}

// MARK: - Hashable & Equatable

extension Anime: Hashable {
    /// Hash implementation based on unique MAL ID
    func hash(into hasher: inout Hasher) {
        hasher.combine(malId)
    }
    
    /// Equality check based on MAL ID
    static func == (lhs: Anime, rhs: Anime) -> Bool {
        return lhs.malId == rhs.malId
    }
}


