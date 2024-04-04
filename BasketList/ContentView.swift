//
//  ContentView.swift
//  BasketList
//
//  Created by Leila on 4/3/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 21.3, longitude: -157.5),
            span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7)
        )
    )
    
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.square")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .frame(width: 40, height: 40)
                            .clipShape(.circle)
                            .onLongPressGesture {
                                selectedPlace = location
                            }
                    }
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
            .sheet(item: $selectedPlace) { place in // aut0 unwrap opt when value set
                Text(place.name)
            }
        }
    }
}

#Preview {
    ContentView()
}
