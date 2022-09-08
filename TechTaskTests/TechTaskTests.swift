//
//  TechTaskTests.swift
//  TechTaskTests
//
//  Created by Дмитрий Игнатьев on 08.09.2022.
//

import XCTest
@testable import TechTask

final class StorageProviderTests: XCTestCase {
    private let sut = MobileStorageProvider()
    private var anyMobile: Mobile {
        return .init(imei: "some", model: "some")
    }
    
    func testStorageIsEmptyWillRetunsEmpty() throws {
        XCTAssertTrue(sut.getAll().isEmpty)
    }
    
    func testIfMobileHasAddedReturnMobile() throws {
        let savedResult = try sut.save(self.anyMobile)
        XCTAssertEqual(savedResult, self.anyMobile)
        XCTAssertEqual(sut.getAll(), [self.anyMobile])
    }
    
    func testIfAttemptAddingNonUniqueMobileThrowsErr() {
        _ = try? sut.save(self.anyMobile)
        XCTAssertThrowsError(try sut.save(self.anyMobile))
        XCTAssertEqual(sut.getAll(), [self.anyMobile])
    }
    
    func testMobileContainsInStorageRemoveMobile() throws {
        _ = try? sut.save(self.anyMobile)
        try sut.delete(self.anyMobile)
        XCTAssertEqual(sut.getAll(), [self.anyMobile])
    }
    
    func testAttemptToRemoveNonExistedMobileThrowsErr() throws {
        XCTAssertThrowsError(try sut.delete(self.anyMobile))
    }
    
}
