//
//  synaposisUseCase.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 23/09/2022.
//

import Foundation
import Resolver

protocol SynaposisUseCaseProtocol: AnyObject {
}


class SynaposisUseCase: SynaposisUseCaseProtocol {
    
    
    
    @Injected var repo: SynaposisRepo
    
    
}
