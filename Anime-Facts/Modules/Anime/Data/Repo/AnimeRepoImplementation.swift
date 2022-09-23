//
//  AnimeRepoImplementation.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import RxSwift
import Resolver


class AnimeRepoImplementation: AnimeRepo {
        
    @Injected private var network: AnimeNetwork
    
    func animes(year: String, season: Season) -> Single<AnimeRequest> {
        return network.fetchAnime(year: year, season: season)
    }
    
    
    
    
    
}
