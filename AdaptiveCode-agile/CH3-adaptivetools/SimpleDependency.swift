//
//  SimpleDependency.swift
//  AdaptiveCode-agile
//
//  Created by Ahmad medo on 18/12/2022.
//

import Foundation

// direct object instantiation—is an example of “inappropriate intimacy” code smell.
// An example of how Instantiating objects prevents code from being adaptive.
fileprivate protocol UserRepositoryProtocol{
    func GetUserByID(_ userID: UUID)->User
}
fileprivate class UserRepository: UserRepositoryProtocol{
    
    func GetUserByID(_ userID: UUID)->User{
        return User()
    }
    
}
fileprivate class User{
    func ChangePassword(_ newPassword: String){
    }
}

// MARK: Security Service
fileprivate protocol SecurityServiceProtocol{
    func ChangeUsersPassword(_ userID: UUID,
                             _ newPassword: String)
}

fileprivate class SecurityService: SecurityServiceProtocol{
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func ChangeUsersPassword(_ userID: UUID,
                             _ newPassword: String){
        
        var user = userRepository.GetUserByID(userID)
        user.ChangePassword(newPassword)
        
    }
}
//MARK: Account Controller
fileprivate class AccountController{
    
    private let securityService: SecurityServiceProtocol
    
    init(securityService: SecurityServiceProtocol) {
        self.securityService = securityService
    }
        
    func ChangePassword(userID: UUID, newPassword: String){
        
        self.securityService.ChangeUsersPassword(userID, newPassword)
    }
    
}
