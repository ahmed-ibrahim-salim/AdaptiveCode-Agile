//
//  SimpleDependency.swift
//  AdaptiveCode-agile
//
//  Created by Ahmad medo on 18/12/2022.
//

import Foundation

// direct object instantiation—is an example of “inappropriate intimacy” code smell.
// An example of how instantiating objects prevents code from being adaptive.
class User{
    
    func ChangePassword(_ newPassword: String){
        
    }
}

protocol UserRepositoryProtocol{
    func GetByID(_ userID: UUID)->User
}
class UserRepository: UserRepositoryProtocol{
    
    func GetByID(_ userID: UUID)->User{
        return User()
    }
    
}

class SecurityService: SecurityServiceProtocol{
    
    private var userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func ChangeUsersPassword(_ userID: UUID,
                             _ newPassword: String){
        
        var user = userRepository.GetByID(userID)
        user.ChangePassword(newPassword)
        
    }
}

protocol SecurityServiceProtocol{
    func ChangeUsersPassword(_ userID: UUID,
                             _ newPassword: String)
}

class AccountController{
    
    private var securityService: SecurityServiceProtocol
    
    init(securityService: SecurityServiceProtocol) {
        self.securityService = securityService
    }
        
    func ChangePassword(userID: UUID, newPassword: String){
        
        self.securityService.ChangeUsersPassword(userID, newPassword)
    }
    
}
