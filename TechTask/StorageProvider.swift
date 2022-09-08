//
//  StorageProvider.swift
//  TechTask
//
//  Created by Дмитрий Игнатьев on 08.09.2022.

import Foundation

// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory

public protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}
public struct Mobile: Hashable {
    let imei: String
    let model: String
}

public enum StorageError: Error {
    case attemptToAddNonUniqueElement
    case attemptToRemoveNonExistElement
}

public class MobileStorageProvider: MobileStorage {
    
    private var storage = [String: Mobile]()
    
    public func getAll() -> Set<Mobile> {
        Set(storage.values)
    }
    
    public func findByImei(_ imei: String) -> Mobile? {
        self.storage[imei]
    }
    
    public func save(_ mobile: Mobile) throws -> Mobile {
        if exists(mobile) {
            throw StorageError.attemptToAddNonUniqueElement
        }
        self.storage[mobile.imei] = mobile
        return mobile
        
    }
    
    public func delete(_ product: Mobile) throws {
        guard exists(product) else {
            throw StorageError.attemptToRemoveNonExistElement
        }
    }
    
    public func exists(_ product: Mobile) -> Bool {
        self.findByImei(product.imei) != nil
    }
    
}
