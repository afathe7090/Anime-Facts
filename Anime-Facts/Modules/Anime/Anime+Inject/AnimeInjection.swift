//
//  AnimeInjection.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation
import Resolver


extension Resolver {
        
    static func animeDependicesService(){
        
        register { AnimeRepoImplementation() }
        .implements(AnimeRepo.self)
        
        register { AnimeUseCase() }
        .implements(AnimeUseCaseProtocol.self)
        
        register { AnimeViewModel() }
        .implements(AnimeViewModelProtocol.self)
        
        register { AnimeViewController() }
    }
    
    
    
}
