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
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        print("Tapped at \(coordinate)")
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
