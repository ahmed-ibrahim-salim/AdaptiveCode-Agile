//
//  Strategy.swift
//  AdaptiveCode-agile
//
//  Created by magdy khalifa on 27/03/2023.
//

import Foundation

protocol FluentProtocol{
  func DoSomething()->IFluentInterface
  func DoSomethingElse()->IFluentInterface;
  func ThisMethodIsNotFluent()
}

class FluentImplementation : FluentProtocol{
 func DoSomething()->IFluentInterface{
    return self
  }

  func DoSomethingElse()->IFluentInterface{
  return self
  }

  func ThisMethodIsNotFluent(){
  }
}