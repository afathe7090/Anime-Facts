//
//  SynopsisInjection.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 23/09/2022.
//

import Foundation
import Resolver

extension Resolver {
    
    static func configureSynopsisServices(){
        
        register {
            SynaposisRepoImpolementation()
        }.implements(SynaposisRepo.self)
        
        
        register {
            SynaposisUseCase()
        }.implements(SynaposisUseCaseProtocol.self)
        
        
        register { SynaposisViewModel() }
        .implements(SynaposisViewModelProtocol.self)
        
                
        register { (resolver , argument)-> SynaposisVC in
            let synaposisVc = SynaposisVC()
            resolver.resolve(SynaposisViewModel.self).animeSynaposis = argument()
            return synaposisVc
        }
    }
    
    
}
