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
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(viewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.square")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .frame(width: 40, height: 40)
                            .clipShape(.circle)
                            .onLongPressGesture {
                                viewModel.selectedPlace = location
                            }
                    }
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    viewModel.locations.append(newLocation)
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in // aut0 unwrap opt when value set
                EditView(location: place) { newLocation in           // closure - when save button
                    if let index = viewModel.locations.firstIndex(of: place) { // find prev unedited place in arr
                        viewModel.locations[index] = newLocation               // replace it with newLoc
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
