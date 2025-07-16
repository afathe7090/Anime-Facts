//
//  Season.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 22/09/2022.
//

import Foundation

/**
 * Season represents the different seasons of the year for anime releases.
 * This enum is used to categorize anime by their broadcast season.
 */
enum Season: String, CaseIterable {
    case winter = "winter"
    case spring = "spring"
    case summer = "summer"
    case fall = "fall"
    
    /// Array of all season raw values for convenience
    static let allSeasonNames = allCases.map { $0.rawValue }
    
    /// Display name for the season with proper capitalization
    var displayName: String {
        return rawValue.capitalized
    }
    
    /// Emoji representation for each season
    var emoji: String {
        switch self {
        case .winter:
            return "❄️"
        case .spring:
            return "🌸"
        case .summer:
            return "☀️"
        case .fall:
            return "🍂"
        }
    }
    
    /// Months associated with each season
    var months: [String] {
        switch self {
        case .winter:
            return ["December", "January", "February"]
        case .spring:
            return ["March", "April", "May"]
        case .summer:
            return ["June", "July", "August"]
        case .fall:
            return ["September", "October", "November"]
        }
    }
    
    /// Description of the season
    var description: String {
        switch self {
        case .winter:
            return "Winter anime season (December - February)"
        case .spring:
            return "Spring anime season (March - May)"
        case .summer:
            return "Summer anime season (June - August)"
        case .fall:
            return "Fall anime season (September - November)"
        }
    }
    
    /// Returns the current season based on current date
    static var current: Season {
        let month = Calendar.current.component(.month, from: Date())
        
        switch month {
        case 3...5:
            return .spring
        case 6...8:
            return .summer
        case 9...11:
            return .fall
        default:
            return .winter
        }
    }
    
    /// Returns the next season in chronological order
    var next: Season {
        switch self {
        case .winter:
            return .spring
        case .spring:
            return .summer
        case .summer:
            return .fall
        case .fall:
            return .winter
        }
    }
    
    /// Returns the previous season in chronological order
    var previous: Season {
        switch self {
        case .winter:
            return .fall
        case .spring:
            return .winter
        case .summer:
            return .spring
        case .fall:
            return .summer
        }
    }
}

// MARK: - Season Extensions

extension Season: CustomStringConvertible {
    /// String representation of the season
    var description: String {
        return "\(emoji) \(displayName)"
    }
}

extension Season: Comparable {
    /// Comparison based on seasonal order
    static func < (lhs: Season, rhs: Season) -> Bool {
        let order: [Season] = [.winter, .spring, .summer, .fall]
        guard let lhsIndex = order.firstIndex(of: lhs),
              let rhsIndex = order.firstIndex(of: rhs) else {
            return false
        }
        return lhsIndex < rhsIndex
    }
}

