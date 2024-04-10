//
//  ContentView-ViewModel.swift
//  BasketList
//
//  Created by Leila on 4/10/24.
//

import CoreLocation
import Foundation
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations = [Location]()
        var selectedPlace: Location?
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) { // find prev unedited place in arr
                locations[index] = location               // replace it with newLoc
            }
        }
    }
}
