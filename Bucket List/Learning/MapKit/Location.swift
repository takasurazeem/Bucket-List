//
//  Location.swift
//  Bucket List
//
//  Created by Takasur Azeem on 13/07/2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
