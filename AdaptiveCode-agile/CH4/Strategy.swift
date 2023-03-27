//
//  Strategy.swift
//  AdaptiveCode-agile
//
//  Created by magdy khalifa on 27/03/2023.
//

import Foundation

public protocol IStrategy
{
    func  Execute();
}
// . . .
public class ConcreteStrategyA : IStrategy
{
    public func  Execute()
    {
        print("ConcreteStrategyA.Execute()");
    }
}
// . . .
public class ConcreteStrategyB : IStrategy
{
    public func  Execute()
    {
        print("ConcreteStrategyB.Execute()");
    }
}
// . . .
public class Context{
    
    private let  strategyA: IStrategy = ConcreteStrategyA();
    private let  strategyB: IStrategy = ConcreteStrategyB();
    private var currentStrategy: IStrategy;
    
    public init(){
        currentStrategy = strategyA;
    }
    
    public func DoSomething(){
        currentStrategy.Execute()
        
        // swap strategy with each call
        currentStrategy = (currentStrategy is ConcreteStrategyA) ? strategyB : strategyA
    }
}
