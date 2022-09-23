//
//  AnimeProvider.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import RxSwift
import Moya

protocol AnimeNetwork {
    func fetchAnime(year: String, season: Season) -> Single<AnimeRequest> 
}


class AnimeNetworkImplementaion: AnimeNetwork {
    
    private let provider = MoyaProvider<AnimeServices>()
    
    func fetchAnime(year: String, season: Season) -> Single<AnimeRequest> {
       return provider.rx
            .request(.readAnimes(year, season))
            .filterSuccessfulStatusCodes()
            .map(AnimeRequest.self)
        
    }
    
    
}
