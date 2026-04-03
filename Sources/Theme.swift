import Cocoa

struct Theme {
    enum InputType {
        case bezeled
        case simple
    }

    var colorBG: Int
    var colorFG: Int
    var colorSel: Int
    var colorAccent: Int

    var fontSizeSearch: CGFloat = 18
    var fontSizeList: CGFloat = 14

    var contentPadding: CGFloat = 8

    var lineCount = 10

    var inputType: InputType = .simple

    init() {
        let dark = NSApp.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
        if dark {
            colorBG     = 0x1E1E1E
            colorFG     = 0xF0F0F0
            colorSel    = 0x3A3A3A
            colorAccent = 0x007AFF
        } else {
            colorBG     = 0xF5F5F5
            colorFG     = 0x1E1E1E
            colorSel    = 0xD0D0D0
            colorAccent = 0x007AFF
        }
    }

    init(from dict: [String: TOML.Value]) {
        self.init()
        if case .int(let v) = dict["colorBG"] { colorBG = v }
        if case .int(let v) = dict["colorFG"] { colorFG = v }
        if case .int(let v) = dict["colorSel"] { colorSel = v }
        if case .int(let v) = dict["colorAccent"] { colorAccent = v }
        if case .int(let v) = dict["fontSizeSearch"] { fontSizeSearch = CGFloat(v) }
        if case .int(let v) = dict["fontSizeList"] { fontSizeList = CGFloat(v) }
        if case .int(let v) = dict["contentPadding"] { contentPadding = CGFloat(v) }
        if case .int(let v) = dict["lineCount"] { lineCount = v }
        if case .string(let v) = dict["inputType"] {
            switch v {
            case "bezeled": inputType = .bezeled
            case "simple": inputType = .simple
            default: ()
            }
        }
    }

    static func hex(_ value: Int) -> NSColor {
        NSColor(
            red: CGFloat((value >> 16) & 0xFF) / 255.0,
            green: CGFloat((value >> 8) & 0xFF) / 255.0,
            blue: CGFloat(value & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
}
