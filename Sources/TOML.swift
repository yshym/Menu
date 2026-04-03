enum TOML {
    enum Value {
        case string(String)
        case int(Int)
        case bool(Bool)
    }

    static func parse(_ content: String) -> [String: [String: Value]] {
        var result: [String: [String: Value]] = [:]
        var section = ""  // empty string = top-level keys
        for line in content.split(separator: "\n", omittingEmptySubsequences: false) {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.isEmpty || trimmed.hasPrefix("#") { continue }
            if trimmed.hasPrefix("[") && trimmed.hasSuffix("]") {
                section = String(trimmed.dropFirst().dropLast()).trimmingCharacters(in: .whitespaces)
                continue
            }
            let parts = trimmed.split(separator: "=", maxSplits: 1)
            guard parts.count == 2 else { continue }
            let key = parts[0].trimmingCharacters(in: .whitespaces)
            let raw = parts[1].trimmingCharacters(in: .whitespaces)
            let value: Value
            if let i = Int(raw) {
                value = .int(i)
            } else if raw == "true" || raw == "false" {
                value = .bool(raw == "true")
            } else if raw.hasPrefix("\"") && raw.hasSuffix("\"") {
                value = .string(String(raw.dropFirst().dropLast()))
            } else {
                value = .string(raw)
            }
            result[section, default: [:]][key] = value
        }
        return result
    }
}
