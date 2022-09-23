//
//  ApplicationInject.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation
import Resolver


extension Resolver: ResolverRegistering{
    
    public static func registerAllServices() {
        animeDependicesService()
        
        registerNetworkMoyaService()
    }
    
}
