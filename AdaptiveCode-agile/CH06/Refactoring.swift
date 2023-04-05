//
//  Ch06.swift
//  AdaptiveCode-agile
//
//  Created by Ahmad medo on 27/03/2023.
//

import Foundation

enum AccountType{
    case Silver
    case Gold
    case Platinum
}

// Super class uses factory
class Account{
    private var accountBaseProtocol: Account?
    
    private(set) var Balance: Double = 0.0
    private(set) var RewardPoints: Int = 0
    
    init(accountFactory: AccountFactoryProtocol) {
        self.accountFactory = accountFactory
        
    }
    
    var accountFactory: AccountFactoryProtocol
    func createAccount(type: AccountType)->Account{
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

// MARK: Factory
protocol AccountFactoryProtocol{
    func createAccount(type: AccountType)->Account
}
class AccountFactory: AccountFactoryProtocol{
    // factory Method, creates class based on provided type
    func createAccount(type: AccountType)->Account{
        var account: Account
        
        switch type{
        case AccountType.Silver:
            account = SilverAccount(accountFactory: AccountFactory())
        case AccountType.Gold:
            account = GoldAccount(accountFactory: AccountFactory())
        case AccountType.Platinum:
            account = PlatinumAccount(accountFactory: AccountFactory())
        }
        return account
    }
}


// Refused bequest --> this subclass refuses to use other functions from superclass
private class StandardAccount: Account{
    // this new account does not have reward points
    override func CalculateRewardPoints(_ amount: Double) -> Int {
        return 0
    }
}

// These classes are private
private class SilverAccount: Account{
    private let SilverTransactionCostPerPoint: Double = 10.0
    

    override func CalculateRewardPoints(_ amount: Double) -> Int {
        return Int(floor(amount / SilverTransactionCostPerPoint));
    }
}

private class GoldAccount: Account{
    
    private let GoldBalanceCostPerPoint: Double = 5.0
    private let GoldTransactionCostPerPoint: Double = 5.0
    

    
    override func CalculateRewardPoints(_ amount: Double) -> Int {
        return Int(floor((Balance / 10000 * GoldBalanceCostPerPoint) + (amount / GoldTransactionCostPerPoint)))
    }
}
private class PlatinumAccount: Account{
    
    private let PlatinumTransactionCostPerPoint: Double = 2.0
    private let PlatinumBalanceCostPerPoint: Double = 10.0
    
    override func CalculateRewardPoints(_ amount: Double) -> Int {
        return Int(ceil(((Balance / 10000 * PlatinumBalanceCostPerPoint) + (amount / PlatinumTransactionCostPerPoint))))
    }
}

// MARK: Rewarding
protocol IRewardCard{
    var RewardPoints: Int { get }
    func CalculateRewardPoints(transactionAmount: Double, accountBalance: Double )
}

private class BronzeRewardCard : IRewardCard{
    private (set) var RewardPoints: Int = 0
    private let BronzeTransactionCostPerPoint = 20.0

    func CalculateRewardPoints(transactionAmount: Double,
                               accountBalance: Double){

        RewardPoints += max(Int(floor(transactionAmount /
                                      BronzeTransactionCostPerPoint)), 0);
    }
}

private class PlatinumRewardCard : IRewardCard{
    private (set) var RewardPoints: Int = 0
    
    private let PlatinumTransactionCostPerPoint = 2.0;
    private let PlatinumBalanceCostPerPoint = 1000.0;
    
    func CalculateRewardPoints(transactionAmount: Double,
                               accountBalance: Double){
        RewardPoints += Int(max(ceil(
            (accountBalance / PlatinumBalanceCostPerPoint) +
            (transactionAmount / PlatinumTransactionCostPerPoint)), 0))
    }
    
}
