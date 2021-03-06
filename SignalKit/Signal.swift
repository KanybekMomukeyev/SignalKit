//
//  Signal.swift
//  SignalKit
//
//  Created by Yanko Dimitrov on 3/4/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import Foundation

public final class Signal<T>: SignalType {
    public typealias ObservationValue = T
    
    public var disposableSource: Disposable?
    internal private(set) var observers = Bag<T -> Void>()
    private var mutex = pthread_mutex_t()
    
    public init() {}
    
    deinit {
        
        dispose()
    }
}

// MARK: - Observable

extension Signal {
    
    public func addObserver(observer: ObservationValue -> Void) -> Disposable {
        
        pthread_mutex_lock(&mutex)
        
        let token = observers.insertItem(observer)
        
        pthread_mutex_unlock(&mutex)
        
        return DisposableAction { [weak self] in
            
            self?.removeItemWithToken(token)
        }
    }
    
    public func sendNext(value: ObservationValue) {
        
        pthread_mutex_lock(&mutex)
        
        for (_, observer) in observers {
            
            observer(value)
        }
        
        pthread_mutex_unlock(&mutex)
    }
    
    internal func removeItemWithToken(token: RemovalToken) {
        
        pthread_mutex_lock(&mutex)
        
        observers.removeItemWithToken(token)
        
        pthread_mutex_unlock(&mutex)
    }
}
