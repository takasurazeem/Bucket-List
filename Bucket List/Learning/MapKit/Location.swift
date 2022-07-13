//
//  Location.swift
//  Bucket List
//
//  Created by Takasur Azeem on 13/07/2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

extension Location {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Holy Kaaba 🕋", description: "sacred house of Allah.", latitude: 21.4225, longitude: 39.8262)

}
