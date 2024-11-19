//
//  ContentView.swift
//  BucketList
//
//  Created by Izabela Marcinkowska on 2024-11-18.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    var body: some View {
        VStack {
            Map(initialPosition: startPosition)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
