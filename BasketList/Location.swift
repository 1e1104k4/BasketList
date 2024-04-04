//
//  Location.swift
//  BasketList
//
//  Created by Leila on 4/3/24.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Maui", description: "I was here", latitude: 20.85593, longitude: -156.60155)
    #endif
    
}
