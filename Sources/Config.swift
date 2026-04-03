import Cocoa

struct Config {
    let theme: Theme

    static func parse(_ path: String) -> Self? {
        let expandedPath = NSString(string: path).expandingTildeInPath;
        guard let content = try? String(contentsOfFile: expandedPath, encoding: .utf8) else { return nil }
        var toml = TOML.parse(content)
        // Normalize hex colors
        for (key, value) in (toml["theme"] ?? [:]) {
            if case .string(let s) = value, s.hasPrefix("#"), let int = Int(s.trimmingPrefix("#"), radix: 16) {
                toml["theme"]![key] = .int(int)
            }
        }
        return Self(theme: Theme(from: toml["theme"] ?? [:]))
    }
}
