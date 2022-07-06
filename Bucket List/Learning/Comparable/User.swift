//
//  User.swift
//  Bucket List
//
//  Created by Takasur Azeem on 06/07/2022.
//

import Foundation

struct User: Identifiable, Comparable {
    
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
    
}
    
