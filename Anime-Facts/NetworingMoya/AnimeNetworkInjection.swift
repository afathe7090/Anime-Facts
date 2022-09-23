//
//  NetworkInjection.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation
import Resolver
 

extension Resolver {
    
    static func registerNetworkMoyaService(){
        register {
            AnimeNetworkImplementaion()
        }.implements(AnimeNetwork.self)
    }
    
}
