//
//  AnimeUseCase.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation
import Resolver
import RxSwift


protocol AnimeUseCaseProtocol{
    func animes(year: String, season: Season) -> Observable<[Anime]>
}


class AnimeUseCase: AnimeUseCaseProtocol {
    
    @Injected var repo: AnimeRepo
    
    func animes(year: String, season: Season) -> Observable<[Anime]> {
        return  repo.animes(year: year, season: season).asObservable().map({ $0.anime })
        
    }
    
    
}
