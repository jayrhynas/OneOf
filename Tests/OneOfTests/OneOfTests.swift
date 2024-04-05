import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(OneOfMacros)
import OneOfMacros

let testMacros: [String: Macro.Type] = [
    "oneOf": OneOfMacro.self,
]
#endif

final class OneOfTests: XCTestCase {
    func testMacro() throws {
        #if canImport(OneOfMacros)
        assertMacroExpansion(
            """
            #oneOf(1, 1, 2, 3)
            """,
            expandedSource: """
            {
                switch 1 {
                case 1:
                    true
                case 2:
                    true
                case 3:
                    true
                default:
                    false
                }
            }()
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
