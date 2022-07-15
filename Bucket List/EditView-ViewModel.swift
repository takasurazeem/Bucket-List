//
//  EditView-ViewModel.swift
//  Bucket List
//
//  Created by Takasur Azeem on 14/07/2022.
//

import Foundation

extension EditView {
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    class ViewModel: ObservableObject {
        
        @Published var name = ""
        @Published var description = ""
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        private var location: Location
        
        init(location: Location) {
            self.location = location
            
            name = location.name
            description = location.description
        }
        
        func save(completion: @escaping (_ newLocation: Location) -> Void) {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            completion(newLocation)
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                // success - convert the array values to our pages array
                pages = items.query.pages.values.sorted()
            } catch {
                // if we're still here it means the request failed somehow
                loadingState = .failed
            }
        }
    } // ViewModel
    
    // MARK: - Models
    
    struct Result: Codable {
        let query: Query
    }

    struct Query: Codable {
        let pages: [Int: Page]
    }

    struct Page: Codable, Comparable {
        let pageid: Int
        let title: String
        let terms: [String: [String]]?
        
        var description: String {
            terms?["description"]?.first ?? "No further information"
        }
        
        static func <(lhs: Page, rhs: Page) -> Bool{
            lhs.title < rhs.title
        }
    }

    
} // Extension EditView

