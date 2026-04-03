import Cocoa

class MenuRowView: NSTableRowView {
    let theme: Theme

    init(theme: Theme) {
        self.theme = theme
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func drawSelection(in dirtyRect: NSRect) {
        Theme.hex(theme.colorSel).setFill()
        NSBezierPath.fill(bounds)
    }
}
