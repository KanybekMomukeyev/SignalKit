//
//  MockDisposable.swift
//  SignalKit
//
//  Created by Yanko Dimitrov on 8/12/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation
@testable import SignalKit

class MockDisposable: Disposable {
    
    var isDisposeCalled = false
    
    func dispose() {
        
        isDisposeCalled = true
    }
}
