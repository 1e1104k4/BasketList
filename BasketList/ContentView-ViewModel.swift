//
//  ContentView-ViewModel.swift
//  BasketList
//
//  Created by Leila on 4/10/24.
//

import Foundation
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        var locations = [Location]()
        var selectedPlace: Location?
    }
}
