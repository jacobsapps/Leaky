//
//  LeakDetector.swift
//  Leaky
//
//  Created by Jacob Bartlett on 14/01/2025.
//

import Foundation
import Synchronization

protocol LeakDetectable: AnyObject {
    var maxInstances: Int { get }
    func track()
}

extension LeakDetectable {
    var maxInstances: Int { 1 }
}

final class LeakDetector {
    
    static let shared = LeakDetector()
    
    // You can use OSAllocatedUnfairLock to make the access thread-safe before iOS 18
    private let refStore = Mutex([String: WeakRefStore]())
    
    func check(_ instance: LeakDetectable) {
        let className = String(describing: instance)
        
        refStore.withLock { store in
            if store[className] == nil {
                store[className] = WeakRefStore()
            }
            let instances = store[className]?.numberOfLiveInstances(including: instance) ?? 0
            assert(instances <= instance.maxInstances, "Memory leak detected!")
        }
    }
}

private final class WeakRefStore {
    private var refs = [WeakRef]()
    
    func numberOfLiveInstances(including ref: AnyObject) -> Int {
        refs.append(WeakRef(ref))
        refs = refs.filter { !$0.isDeallocated }
        return refs.count
    }
}

private final class WeakRef {
    weak var ref: AnyObject?
    var isDeallocated: Bool { ref == nil }
    init(_ ref: AnyObject?) {
        self.ref = ref
    }
}
