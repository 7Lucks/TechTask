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

/// we create enam for our Err
/// attemptToAddNonUniqueElement - call this error when we trying to add a non unique element to our storage
/// attemptToRemoveNonExistElement - call this error when we trying to remove non existed element from our storage
public enum StorageError: Error {
    case attemptToAddNonUniqueElement
    case attemptToRemoveNonExistElement
}

public class MobileStorageProvider: MobileStorage {
    
    /// storage - we create a dictionary that will store the Mobile model. The dictionary will be convenient to use because there is a unique imei code and it is very fast for searching by the key
    private var storage = [String: Mobile]()
    
    /// Obtaining all previously saved data and casted to "Set" data structure
    public func getAll() -> Set<Mobile> {
        Set(storage.values)
    }
    
    /// a method that allows you to find a value by its unique Imei
    /// - Parameter imei: Unique string imei number
    public func findByImei(_ imei: String) -> Mobile? {
        self.storage[imei]
    }
    
    /// Here we  save all Mobile data we receive
    /// - Parameter if exists:  check if we are trying to add an already existing imei, this should throw an error attemptToAddNonUniqueElement
    public func save(_ mobile: Mobile) throws -> Mobile {
        if exists(mobile) {
            throw StorageError.attemptToAddNonUniqueElement
        }
        self.storage[mobile.imei] = mobile
        return mobile
        
    }
    
    /// deleting an earlier saved date
    /// - Parameter attemptToRemoveNonExistElement: we obtain this error if we try to remove a non-existent element
    public func delete(_ product: Mobile) throws {
        guard exists(product) else {
            throw StorageError.attemptToRemoveNonExistElement
        }
    }
    
    /// check if this imei is already exists
    public func exists(_ product: Mobile) -> Bool {
        self.findByImei(product.imei) != nil
    }
    
}
