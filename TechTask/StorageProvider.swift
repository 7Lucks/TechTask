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

/// Storage errors
public enum StorageError: Error {
    ///call this error when we trying to add a non unique element to our storage
    case attemptToAddNonUniqueElement
    ///call this error when we trying to remove non existed element from our storage
    case attemptToRemoveNonExistElement
}

public class MobileStorageProvider: MobileStorage {
    
    /// storage -  a dictionary that will store the Mobile model. It will be convenient to use because there is a unique imei code and it is helps with a quick search by the key
    private var storage = [String: Mobile]()
    
    /// Obtaining all previously saved data from the storage dict
    /// - Returns: Set of our Mobile
    public func getAll() -> Set<Mobile> {
        Set(self.storage.values)
    }
    
    /// Method that allows you to find a value by its unique imei from the storage (after save method)
    /// - Parameter imei: Unique string imei number.
    /// - Returns: found 'Mobile' if Imei exist
    public func findByImei(_ imei: String) -> Mobile? {
        self.storage[imei]
    }
    
    /// Save all Mobile data we receive
    /// - Parameter if: here we check for existed data to save from the storage dict.
    /// - Throws: if we are trying to add an already existing imei, this should throw an error attemptToAddNonUniqueElement.
    /// - Returns: 'Mobile' after saving some data
    public func save(_ mobile: Mobile) throws -> Mobile {
        if self.exists(mobile) {
            //
            throw StorageError.attemptToAddNonUniqueElement
        }
        self.storage[mobile.imei] = mobile
        return mobile
    }
    
    /// Deleting a previously saved 'Mobile' from the storage
    /// - Throws: we obtain this error if we trying to remove a non-existent element
    public func delete(_ product: Mobile) throws {
        guard self.exists(product) else {
            throw StorageError.attemptToRemoveNonExistElement
        }
            self.storage[product.imei] = nil
    }
    
    /// Check if an Imei is already exists in storage
    public func exists(_ product: Mobile) -> Bool {
        self.findByImei(product.imei) != nil
    }
    
}
