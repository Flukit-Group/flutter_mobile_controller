import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    // Hide system icon buttons in title bar.
    self.standardWindowButton(.closeButton)?.isHidden = true
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true
    // Transparent view
    self.isOpaque = false
    self.backgroundColor = .clear
    // Add the blur layer
    let blurView = NSVisualEffectView()
    blurView.blendingMode = NSVisualEffectView.BlendingMode.behindWindow
    //blurView.material = NSVisualEffectView.Material.Medium
    blurView.state = NSVisualEffectView.State.active
    let view = contentViewController?.view.superview;
    blurView.frame = CGRect(x: 0, y: 0, width: 2000, height: 1600)
    view?.addSubview(blurView, positioned: NSWindow.OrderingMode.below, relativeTo: nil)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }

}
