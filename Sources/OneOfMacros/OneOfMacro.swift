import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct OneOfMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let valueToTest = node.argumentList.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        let valuesArray = node.argumentList.dropFirst().map(\.expression)
        guard !valuesArray.isEmpty else {
            fatalError("compiler bug: the macro does not have any arguments to check against")
        }
        
        let cases = valuesArray.map {
            "case \($0): true"
        }.joined(separator: "\n")
        
        return """
        {
            switch \(raw: valueToTest) {
            \(raw: cases)
            default: false
            }
        }()
        """
    }
}

@main
struct OneOfPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        OneOfMacro.self,
    ]
}
