//
//  ValidationServiceTests.swift
//  LoginAppTests
//
//  Created by Mateusz Dettlaff on 25/05/2021.
//

@testable import LoginApp
import XCTest

class ValidationServiceTests: XCTestCase {

    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    
    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    func test_is_valid_username() throws {
        XCTAssertNoThrow(try validation.validateUsername("admin"))
    }

    func test_username_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_too_short() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername("abc")) { thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_too_long() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let username = "username with 20 chr"
        
        XCTAssertTrue(username.count == 20)
        XCTAssertThrowsError(try validation.validateUsername(username)) { thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_is_valid_password() throws {
        XCTAssertNoThrow(try validation.validatePassword("password"))
    }
    
    func test_password_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_password_too_short() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("1234567")) { thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_password_too_long() throws {
        let expectedError = ValidationError.passwordTooLong
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("123456789123345689123")) { thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
}
