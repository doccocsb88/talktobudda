// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum Assets {
    public static let accentColor = ColorAsset(name: "AccentColor")
    public static let ds1Background = ImageAsset(name: "ds1-background")
    public static let ds1Banner = ImageAsset(name: "ds1-banner")
    public static let icMoodAnnhien = ImageAsset(name: "ic-mood-annhien")
    public static let icMoodBinhthan = ImageAsset(name: "ic-mood-binhthan")
    public static let icMoodHoanhi = ImageAsset(name: "ic-mood-hoanhi")
    public static let icMoodKhodau = ImageAsset(name: "ic-mood-khodau")
    public static let icMoodPhienmuon = ImageAsset(name: "ic-mood-phienmuon")
    public static let ob1Bg11 = ImageAsset(name: "ob1-bg1 1")
    public static let ob1Bg1 = ImageAsset(name: "ob1-bg1")
    public static let ob1Bg21 = ImageAsset(name: "ob1-bg2 1")
    public static let ob1Bg2 = ImageAsset(name: "ob1-bg2")
    public static let ob1Bg31 = ImageAsset(name: "ob1-bg3 1")
    public static let ob1Bg3 = ImageAsset(name: "ob1-bg3")
    public static let icScriptureBackground = ImageAsset(name: "ic-scripture-background")
    public static let icScriptureBudda = ImageAsset(name: "ic-scripture-budda")
    public static let icScriptureLotus = ImageAsset(name: "ic-scripture-lotus")
    public static let icScriptureTree = ImageAsset(name: "ic-scripture-tree")
    public static let icScriptureVinaya = ImageAsset(name: "ic-scripture-vinaya")
    public static let icStArrow = ImageAsset(name: "ic-st-arrow")
    public static let icStEmail = ImageAsset(name: "ic-st-email")
    public static let icStFaqs = ImageAsset(name: "ic-st-faqs")
    public static let icStGdpr = ImageAsset(name: "ic-st-gdpr")
    public static let icStOthers = ImageAsset(name: "ic-st-others")
    public static let icStPrivacy = ImageAsset(name: "ic-st-privacy")
    public static let icStReview = ImageAsset(name: "ic-st-review")
    public static let icStShare = ImageAsset(name: "ic-st-share")
    public static let icStStore = ImageAsset(name: "ic-st-store")
    public static let icStSubscription = ImageAsset(name: "ic-st-subscription")
    public static let bgMeditationTimer = ImageAsset(name: "bg-meditation-timer")
    public static let buddaConversation = ImageAsset(name: "budda_conversation")
    public static let icBack = ImageAsset(name: "ic-back")
    public static let icBudda01 = ImageAsset(name: "ic-budda-01")
    public static let icBudda02 = ImageAsset(name: "ic-budda-02")
    public static let icClose = ImageAsset(name: "ic-close")
    public static let icDonate = ImageAsset(name: "ic-donate")
    public static let icDonate2 = ImageAsset(name: "ic-donate2")
    public static let icHomeSetting = ImageAsset(name: "ic-home-setting")
    public static let icLotus = ImageAsset(name: "ic-lotus")
    public static let icMeditation = ImageAsset(name: "ic-meditation")
    public static let icPause = ImageAsset(name: "ic-pause")
    public static let icPlay = ImageAsset(name: "ic-play")
    public static let icSearch = ImageAsset(name: "ic-search")
    public static let icSplash = ImageAsset(name: "ic-splash")
    public static let icStop = ImageAsset(name: "ic-stop")
    public static let icVolumeOff = ImageAsset(name: "ic-volume-off")
    public static let icVolumeOn = ImageAsset(name: "ic-volume-on")
    public static let tabbar1 = ImageAsset(name: "tabbar1")
    public static let tabbar2 = ImageAsset(name: "tabbar2")
    public static let tabbar3 = ImageAsset(name: "tabbar3")
    public static let tabbar4 = ImageAsset(name: "tabbar4")
  }
  public enum Colors {
    public static let neutral200 = ColorAsset(name: "Neutral200")
    public static let caption = ColorAsset(name: "caption")
    public static let color4B3621 = ColorAsset(name: "color4B3621")
    public static let color7D5A4F = ColorAsset(name: "color7D5A4F")
    public static let colorBDAE9F = ColorAsset(name: "colorBDAE9F")
    public static let colorE9D8C0 = ColorAsset(name: "colorE9D8C0")
    public static let colorFDF6ED = ColorAsset(name: "colorFDF6ED")
    public static let gray100 = ColorAsset(name: "gray100")
    public static let gray20 = ColorAsset(name: "gray20")
    public static let gray40 = ColorAsset(name: "gray40")
    public static let gray70 = ColorAsset(name: "gray70")
    public static let gray80 = ColorAsset(name: "gray80")
    public static let neutral100 = ColorAsset(name: "neutral100")
    public static let neutral300 = ColorAsset(name: "neutral300")
    public static let neutral400 = ColorAsset(name: "neutral400")
    public static let neutral50 = ColorAsset(name: "neutral50")
    public static let neutral500 = ColorAsset(name: "neutral500")
    public static let neutral600 = ColorAsset(name: "neutral600")
    public static let neutral800 = ColorAsset(name: "neutral800")
    public static let neutral900 = ColorAsset(name: "neutral900")
    public static let neutral950 = ColorAsset(name: "neutral950")
    public static let primaryText1 = ColorAsset(name: "primary-text-1")
    public static let primaryText2 = ColorAsset(name: "primary-text-2")
    public static let primary = ColorAsset(name: "primary")
    public static let primary2 = ColorAsset(name: "primary2")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
