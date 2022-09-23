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
        
        
        register { resolver, argument in
            SynaposisViewModel()
        }.implements(SynaposisViewModelProtocol.self)
        
        
        
        
        register {SynaposisVC()}
        .resolveProperties { resolver, service in
//            resolver.resolve(<#T##type: Service.Type##Service.Type#>, name: <#T##Name?#>, args: <#T##Any?#>)
        }
        
    }
    
    
}
