import Foundation

enum MenuProtocol {
    static let cmdDrun = "drun"
    static let cmdReload = "reload"
    static let cmdStop = "stop"
    static let respSelected = "selected"
    static let respCancelled = "cancelled"
    static let respOk = "ok"

    static func socketPath() -> String {
        "/tmp/menu-\(getuid()).sock"
    }

    static func logPath() -> String {
        "/tmp/menu-server-\(getuid()).log"
    }
}
