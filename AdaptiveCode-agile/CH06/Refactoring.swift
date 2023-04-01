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
    case Copper
}

class Account{
    private let type: AccountType
    
    init(type: AccountType){
        self.type = type
    }
    
    private (set) var Balance: Double = 0.0
    
    private (set) var RewardPoints: Int = 0
    
    private let GoldBalanceCostPerPoint: Double = 5.0
    private let PlatinumBalanceCostPerPoint: Double = 10.0
    
    private let SilverTransactionCostPerPoint: Double = 10.0
    private let GoldTransactionCostPerPoint: Double = 5.0
    private let PlatinumTransactionCostPerPoint: Double = 2.0

    
    func AddTransaction(amount: Double){
        RewardPoints += CalculateRewardPoints(amount);
        Balance += amount;
    }
    
    func CalculateRewardPoints(_ amount: Double)->Int{
        var points = 0
        switch(type){
        case AccountType.Silver:
            points = Int(floor(amount / SilverTransactionCostPerPoint));
        case AccountType.Gold:
            points = Int(floor((Balance / 10000 * GoldBalanceCostPerPoint) + (amount / GoldTransactionCostPerPoint)))
        case AccountType.Platinum:
            points = Int(ceil(((Balance / 10000 * PlatinumBalanceCostPerPoint) + (amount / PlatinumTransactionCostPerPoint))))
        default:
            points = 0;
        }
        return max(points, 0);
    }
}
