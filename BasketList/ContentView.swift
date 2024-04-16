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
    @AppStorage("mapStyle") private var mapStyle = "standard"
    
    var body: some View {
        if viewModel.isUnlocked {
            VStack {
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
                    .mapStyle(mapStyle == "standard" ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in // aut0 unwrap opt when value set
                        EditView(location: place) {           // closure - when save button
                            viewModel.update(location: $0)
                        }
                    }
                }
                Picker("Map Style", selection: $mapStyle) {
                    Text("Standard")
                        .tag("standard")
                    Text("Hybrid")
                        .tag("hybrid")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding(11)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 13))
                .alert("Authentication error", isPresented: $viewModel.isShowingAuthenticationError) {
                    Button("OK") { }
                } message: {
                    Text(viewModel.authenticationError)
                }
        }
    }
}

#Preview {
    ContentView()
}
