import XCTest
@testable import OnoPackage

final class OnoPackageTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OnoPackage().text, "Hello, World!")
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "ocf", ofType: "txt") ?? "Unknown"
        debugPrint(path)
        
        if let url = Bundle.module.url(forResource: "ocf", withExtension: "txt") {
            debugPrint(url)
        } else {
            debugPrint("Unknown URL")
        }
    }
}
