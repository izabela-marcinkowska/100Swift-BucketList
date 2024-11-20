//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Izabela Marcinkowska on 2024-11-20.
//

import Foundation
import MapKit
import CoreLocation

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations = [Location]()
        var selectedPlace: Location?
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
               locations.append(newLocation)
        }
        
        func update(location: Location) {
            guard let selectedPlace else {return}
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
        }
    }
}
