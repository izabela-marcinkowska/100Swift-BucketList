//
//  ContentView.swift
//  BucketList
//
//  Created by Izabela Marcinkowska on 2024-11-18.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var locations = [Location]()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    var body: some View {
        VStack {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(locations) { location in
                        Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let newLocation = Location(id: UUID(), name: "New location", description: "this is new", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        locations.append(newLocation)
                        print("Tapped at \(position)")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
