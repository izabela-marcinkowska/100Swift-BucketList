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
    @State private var selectedPlace: Location?

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
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                                .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in selectedPlace = location })
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let newLocation = Location(id: UUID(), name: "New location", description: "This is new", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        locations.append(newLocation)
                        print("Tapped at \(coordinate)")
                    }
                }
                .sheet(item: $selectedPlace) { place in
                    editView(location: place) { newLocation in
                        if let index = locations.firstIndex(of: place) {
                            locations[index] = newLocation
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
