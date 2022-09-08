//
//  TechTaskTests.swift
//  TechTaskTests
//
//  Created by Дмитрий Игнатьев on 08.09.2022.
//

import XCTest
@testable import TechTask

final class StorageProviderTests: XCTestCase {
    private var anyMobile: Mobile {
        return .init(imei: "some", model: "some")
    }
    
    func testStorageIsEmptyWillRetunsEmpty() throws {
        let sut = MobileStorageProvider()
        XCTAssertTrue(sut.getAll().isEmpty)
    }
    
    func testIfMobileHasAddedReturnMobile() throws {
        let sut = MobileStorageProvider()
        let savedResult = try sut.save(self.anyMobile)
        XCTAssertEqual(savedResult, self.anyMobile)
        XCTAssertEqual(sut.getAll(), [self.anyMobile])
    }
    
    func testIfAttemptAddingNonUniqueMobileThrowsErr() {
        let sut = MobileStorageProvider()
        _ = try? sut.save(self.anyMobile)
        XCTAssertThrowsError(try sut.save(self.anyMobile))
        XCTAssertEqual(sut.getAll(), [self.anyMobile])
    }
    
    func testMobileContainsInStorageRemoveMobile() throws {
        let sut = MobileStorageProvider()
        _ = try sut.save(self.anyMobile)
        try sut.delete(self.anyMobile)
        XCTAssertTrue(sut.getAll().isEmpty)
    }
    
    func testAttemptToRemoveNonExistedMobileThrowsErr() throws {
        let sut = MobileStorageProvider()
        XCTAssertThrowsError(try sut.delete(self.anyMobile))
    }
    
}
