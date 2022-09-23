//
//  Season.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 22/09/2022.
//

import Foundation

enum Season: String , CaseIterable{
    case winter
    case summer
    case spring
    case fall
    
    static let selfArray = allCases.map({$0.rawValue})
}

