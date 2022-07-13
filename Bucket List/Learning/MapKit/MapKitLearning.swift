//
//  MapKitLearning.swift
//  Bucket List
//
//  Created by Takasur Azeem on 13/07/2022.
//

import MapKit
import SwiftUI

struct MapKitLearning: View {
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.6844, longitude: 73.0479), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let locations = [
        Location(name: "Faisal Masjid", coordinate: CLLocationCoordinate2D(latitude: 33.7295, longitude: 73.0372)),
        Location(name: "International Islamic University Islamabad (IIUI)", coordinate: CLLocationCoordinate2D(latitude: 33.6593, longitude: 73.0238))
    ]
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .navigationTitle("Islamabad Explorer")
        }
    }
}

struct MapKitLearning_Previews: PreviewProvider {
    static var previews: some View {
        MapKitLearning()
    }
}
