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
    private let type: AccountType;

    
    
    init(type: AccountType){
        self.type = type
    }
    private (set) var Balance: Double = 0.0
    
    private (set) var RewardPoints: Int = 0
    
    func AddTransaction(amount: Double){
        RewardPoints += CalculateRewardPoints(amount);
        Balance += amount;
    }
    
    func CalculateRewardPoints(_ amount: Double)->Int{
        var points = 0
        switch(type){
        case AccountType.Silver:
            points = Int(floor(amount / 10));
            break;
        case AccountType.Gold:
            points = Int(floor((Balance / 10000 * 5) + (amount / 5)))
            break;
        case AccountType.Platinum:
            points = Int(ceil((Balance / 10000 * 10) + (amount / 2)))
            break;
        default:
            points = 0;
            break;
        }
        return max(points, 0);
    }
}
