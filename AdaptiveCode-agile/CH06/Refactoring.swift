//
//  Ch06.swift
//  AdaptiveCode-agile
//
//  Created by Ahmad medo on 27/03/2023.
//

import Foundation

// MARK: Factory
protocol AccountFactoryProtocol{
    func createAccount(type: AccountType)->AccountBaseProtocol
}
class AccountFactory: AccountFactoryProtocol{
    // factory Method, creates class based on provided type
    func createAccount(type: AccountType)->AccountBaseProtocol{
        var account: AccountBaseProtocol
        
        switch type{
        case AccountType.Silver:
            account = SilverAccount()
        case AccountType.Gold:
            account = GoldAccount()
        case AccountType.Platinum:
            account = PlatinumAccount()
        }
        return account
    }
}

enum AccountType{
    case Silver
    case Gold
    case Platinum
}

class Account{
    private var accountBaseProtocol: AccountBaseProtocol?
    
    private(set) var Balance: Double = 0.0
    private(set) var RewardPoints: Int = 0
    
    init(accountFactory: AccountFactoryProtocol) {
        self.accountFactory = accountFactory
        
    }
    
    var accountFactory: AccountFactoryProtocol
    func createAccount(type: AccountType)->AccountBaseProtocol{
        
        
        return accountFactory.createAccount(type: type)
        
    }
    
    func AddTransaction(amount: Double){
        RewardPoints += CalculateRewardPoints(amount);
        Balance += amount;
    }
    
    func CalculateRewardPoints(_ amount: Double)->Int{
        guard let points = accountBaseProtocol?.CalculateRewardPoints(amount) else{ return 0}
        return max(points, 0);
    }
}

protocol AccountBaseProtocol{
    
    var Balance: Double {get}
    
    var RewardPoints: Int {get}
    
    func CalculateRewardPoints(_ amount: Double)->Int
}

// These classes are private
private class SilverAccount: AccountBaseProtocol{
    private let SilverTransactionCostPerPoint: Double = 10.0
    
    private(set) var Balance: Double = 0.0
    
    private(set) var RewardPoints: Int = 1
    
    func CalculateRewardPoints(_ amount: Double) -> Int {
        return Int(floor(amount / SilverTransactionCostPerPoint));
    }
}

private class GoldAccount: AccountBaseProtocol{
    
    private let GoldBalanceCostPerPoint: Double = 5.0
    private let GoldTransactionCostPerPoint: Double = 5.0
    
    private(set) var Balance: Double = 0.0
    
    private(set) var RewardPoints: Int = 1
    
    
    func CalculateRewardPoints(_ amount: Double) -> Int {
        return Int(floor((Balance / 10000 * GoldBalanceCostPerPoint) + (amount / GoldTransactionCostPerPoint)))
    }
}
private class PlatinumAccount: AccountBaseProtocol{
    
    private let PlatinumTransactionCostPerPoint: Double = 2.0
    private let PlatinumBalanceCostPerPoint: Double = 10.0
    
    private(set) var Balance: Double = 0.0
    
    private(set) var RewardPoints: Int = 1
    
    func CalculateRewardPoints(_ amount: Double) -> Int {
        return Int(ceil(((Balance / 10000 * PlatinumBalanceCostPerPoint) + (amount / PlatinumTransactionCostPerPoint))))
    }
}
