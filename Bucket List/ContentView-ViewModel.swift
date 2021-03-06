//
//  ContentView-ViewModel.swift
//  Bucket List
//
//  Created by Takasur Azeem on 13/07/2022.
//

import MapKit
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.6844, longitude: 73.0479), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var biometricFailed = false
        @Published var biometricFailureMessage = ""
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        if let error = authenticationError {
                            Task { @MainActor in
                                self.biometricFailureMessage = error.localizedDescription
                                self.biometricFailed = true
                            }
                        }
                    }
                }
            } else {
                // no biometrics
            }
        }
        
        
    } // class ViewModel
} // extension ContentView
