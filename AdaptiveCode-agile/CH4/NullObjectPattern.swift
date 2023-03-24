//
//  NullObjectPattern.swift
//  AdaptiveCode-agile
//
//  Created by Ahmad medo on 24/03/2023.
//

import Foundation
// MARK: Problem Statement
fileprivate protocol UserRepositoryProtocol{
    func GetByID(_ id: UUID)->UserProtocol
}
fileprivate class UserRepository: UserRepositoryProtocol{
    func GetByID(_ id: UUID)->UserProtocol{
     return User()
    }
    
}
fileprivate protocol UserProtocol{
    func IncrementSessionTicket()

}
fileprivate class User: UserProtocol{
    var userId = UUID()

    func IncrementSessionTicket(){}

}


fileprivate class Program{
    let userRepository = UserRepository()

// Is checking against null really the responsibility of all clients?
// Checking for null values indicates that you are placing too much unnecessary burden on all of the clients of IRepositoryProtocol.
    func increment(){
        var user = userRepository.GetByID(UUID())

        // Without the Null Object pattern, this line could crash the production
        user.IncrementSessionTicket()
    }

}
// -------------------------------------------------------
// The service code should implement the Null Object pattern.
fileprivate class NullUser: UserProtocol{
    func IncrementSessionTicket(){
        print("the user in nil, and this is null object pattern in action to avoid crashing")
    }
}

fileprivate class UserRepositoryWithNullObject: UserRepositoryProtocol{
    
    let users = [User()]
    
    func GetByID(_ id: UUID)->UserProtocol{
        
        // finding a user in list that can return nil
        var userFound: UserProtocol? = users.first(where: {$0.userId == id})
       
        // checking for nil and return nullUser if it is nil
        guard let userFound = userFound else{
            // you return a special case of the UserProtocol, the NullUser
            return NullUser()
        }
        
        // In fact, a proper NullUser implementation overrides all methods to do as close to nothing as possible.
        return userFound
    }
    
}
