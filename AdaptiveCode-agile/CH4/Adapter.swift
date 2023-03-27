//
//  Adapter.swift
//  AdaptiveCode-agile
//
//  Created by magdy khalifa on 27/03/2023.
//

import Foundation
// Adapter
public protocol IExpectedInterface{
    func MethodA()
}

public class Adapter : IExpectedInterface{
    private var target: LegacyClass
    
    // injected legacy class

    public init(target: LegacyClass){
        self.target = target;
    }
    
    public func MethodA(){
        target.MethodB();
    }
}

public final class LegacyClass{
    
    public func MethodB(){}
    
}

class Client{
    var dependency: IExpectedInterface
    
    // injected adapter
    init(dependency: IExpectedInterface) {
        self.dependency = dependency
    }
    
    func useLegacyClassThroughOurAdapter(){
        dependency.MethodA()
        
    }
    
}
