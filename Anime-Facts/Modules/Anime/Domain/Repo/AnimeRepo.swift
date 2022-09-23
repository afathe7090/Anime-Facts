//
//  AnimeRepo.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import RxSwift

protocol AnimeRepo: AnyObject {
    func animes(year: String, season: Season) -> Single<AnimeRequest>
}
