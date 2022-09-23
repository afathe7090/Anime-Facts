//
//  Anime.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation

// MARK: - User
struct AnimeRequest: Codable {
    let anime: [Anime]
}

// MARK: - Anime
struct Anime: Codable {
    let mal_id: Int
    let url: String
    let title: String
    let image_url: String
    let synopsis: String
    let episodes: Int?
    let members: Int
}


