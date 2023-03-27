//
//  Adapter.swift
//  AdaptiveCode-agile
//
//  Created by magdy khalifa on 27/03/2023.
//

import Foundation
// Adapter
public protocol AdapterProtocol{
    func MethodA()
}

public class Adapter : AdapterProtocol{
    private var target: LegacyClass
    
    // injected legacy class

    public init(target: LegacyClass){
        self.target = target;
    }
    
    public func MethodA(){
        target.MethodB();
    }
}

// Legacy class that the client wants to use
public final class LegacyClass{
    
    public func MethodB(){}
    
}

class Client{
    var dependency: AdapterProtocol
    
    // injected adapter
    init(dependency: AdapterProtocol) {
        self.dependency = dependency
    }
    
    func useLegacyClassThroughOurAdapter(){
        dependency.MethodA()
        
    }
    
}
