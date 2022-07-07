//
//  UserContentView.swift
//  Bucket List
//
//  Created by Takasur Azeem on 06/07/2022.
//

import SwiftUI

struct UserContentView: View {
    
    let users = [
        User(firstName: "Takasur", lastName: "Azeem"),
        User(firstName: "Sikandar", lastName: "Azeem"),
        User(firstName: "Safdar", lastName: "Saleem"),
    ].sorted()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                Text("\(user.firstName) \(user.lastName)")
            }
            .navigationTitle(Text("Names"))
        }
    }
}

struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView()
    }
}
