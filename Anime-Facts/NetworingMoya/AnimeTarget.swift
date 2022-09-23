//
//  AnimeTarget.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import Foundation
import Moya


enum AnimeServices {
    case readAnimes(String,Season)
}

extension AnimeServices: TargetType{
    
    var baseURL: URL{
        return URL(string: "https://jikan1.p.rapidapi.com")!
    }
        
    var path: String {
        switch self {
        case .readAnimes(let year, let season):
            return "/season/\(year)/\(season.rawValue)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["X-RapidAPI-Key": "89ef938d70mshd46bc5e45e06c13p1cae7fjsnc445e85c6b24",
                "X-RapidAPI-Host":"jikan1.p.rapidapi.com"]
    }
        
    
}

