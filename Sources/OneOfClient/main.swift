import OneOf

enum Color {
    case pink, blue, red, orange, mauve
}

let myColor: Color = .red
print(#oneOf(myColor, .pink, .red, .blue))
