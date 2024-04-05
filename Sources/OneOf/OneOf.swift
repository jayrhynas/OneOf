@freestanding(expression)
public macro oneOf<T>(_ valueToTest: T, _ firstValue: T, _ restValues: T...) -> Bool = #externalMacro(module: "OneOfMacros", type: "OneOfMacro")

