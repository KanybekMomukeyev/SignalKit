//
//  MockObservable.swift
//  SignalKit
//
//  Created by Yanko Dimitrov on 8/12/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

class MockObservable<T>: Observable {
    typealias Item = T
    
    let dispatcher: ObserversDispatcher<Item>
    
    init() {
        
        self.dispatcher = ObserversDispatcher<Item>()
    }
}
