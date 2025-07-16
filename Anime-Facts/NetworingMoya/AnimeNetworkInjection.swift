//
//  AnimeNetworkInjection.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation
import Resolver

/**
 * Extension to configure network layer dependencies using Resolver
 */
extension Resolver {
    
    /// Registers network-related dependencies for the anime feature
    static func registerNetworkMoyaService() {
        // Register the concrete implementation of AnimeNetwork
        register { AnimeNetworkImplementation() }
            .implements(AnimeNetwork.self)
            .scope(.application) // Singleton scope for network services
    }
}
