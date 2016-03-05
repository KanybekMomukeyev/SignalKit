//
//  DisposableBag.swift
//  SignalKit
//
//  Created by Yanko Dimitrov on 3/5/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import Foundation

public final class DisposableBag {
    
    internal private(set) var disposables = Bag<Disposable>()
    
    public init() {}
}

extension DisposableBag {
    
    public func insertItem(item: Disposable) -> Disposable {
        
        let token = disposables.insertItem(item)
        
        return DisposableAction { [weak self] in
            
            self?.disposables.removeItemWithToken(token)
        }
    }
}
