//
//  ContentView.swift
//  BucketList
//
//  Created by Izabela Marcinkowska on 2024-11-18.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var mapMode: MapStyle = .standard
    @State private var showingConfirmationAlert = false
    @State private var showingErrorAlert = false
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {

            ZStack {
                
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(Circle())
                                    .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in viewModel.selectedPlace = location })
                            }
                        }
                    }
                    .mapStyle(mapMode)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                            print("Tapped at \(coordinate)")
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        editView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                    .confirmationDialog("Change Map", isPresented: $showingConfirmationAlert) {
                        Button("Normal") { mapMode = .standard}
                        Button("Hybrid") { mapMode = .hybrid}
                        Button("Imaginery") { mapMode = .imagery}
                    }
                    
                }
                VStack (alignment: .leading) {
                    Button {showingConfirmationAlert = true}
                    label: {
                        Image(systemName: "map")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                    }
                        .frame(width: 310, height: 850, alignment: .topLeading)
                        
                }
        
            }
            
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Authentication Failed", isPresented: $showingErrorAlert) {
                    Button("OK", role: .cancel) {
                        viewModel.errorMessage = nil
                    }
                } message: {
                    Text(viewModel.errorMessage ?? "An unknown error occurred.")
                }
        }
    }
}

#Preview {
    ContentView()
}
