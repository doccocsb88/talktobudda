// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
public typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum FontFamily {
  public enum FiraMono {
    public static let bold = FontConvertible(name: "FiraMono-Bold", family: "Fira Mono", path: "FiraMono-Bold.ttf")
    public static let medium = FontConvertible(name: "FiraMono-Medium", family: "Fira Mono", path: "FiraMono-Medium.ttf")
    public static let regular = FontConvertible(name: "FiraMono-Regular", family: "Fira Mono", path: "FiraMono-Regular.ttf")
    public static let all: [FontConvertible] = [bold, medium, regular]
  }
  public enum Inter28pt {
    public static let black = FontConvertible(name: "Inter28pt-Black", family: "Inter 28pt", path: "Inter_28pt-Black.ttf")
    public static let blackItalic = FontConvertible(name: "Inter28pt-BlackItalic", family: "Inter 28pt", path: "Inter_28pt-BlackItalic.ttf")
    public static let bold = FontConvertible(name: "Inter28pt-Bold", family: "Inter 28pt", path: "Inter_28pt-Bold.ttf")
    public static let boldItalic = FontConvertible(name: "Inter28pt-BoldItalic", family: "Inter 28pt", path: "Inter_28pt-BoldItalic.ttf")
    public static let extraBold = FontConvertible(name: "Inter28pt-ExtraBold", family: "Inter 28pt", path: "Inter_28pt-ExtraBold.ttf")
    public static let extraBoldItalic = FontConvertible(name: "Inter28pt-ExtraBoldItalic", family: "Inter 28pt", path: "Inter_28pt-ExtraBoldItalic.ttf")
    public static let extraLight = FontConvertible(name: "Inter28pt-ExtraLight", family: "Inter 28pt", path: "Inter_28pt-ExtraLight.ttf")
    public static let extraLightItalic = FontConvertible(name: "Inter28pt-ExtraLightItalic", family: "Inter 28pt", path: "Inter_28pt-ExtraLightItalic.ttf")
    public static let italic = FontConvertible(name: "Inter28pt-Italic", family: "Inter 28pt", path: "Inter_28pt-Italic.ttf")
    public static let light = FontConvertible(name: "Inter28pt-Light", family: "Inter 28pt", path: "Inter_28pt-Light.ttf")
    public static let lightItalic = FontConvertible(name: "Inter28pt-LightItalic", family: "Inter 28pt", path: "Inter_28pt-LightItalic.ttf")
    public static let medium = FontConvertible(name: "Inter28pt-Medium", family: "Inter 28pt", path: "Inter_28pt-Medium.ttf")
    public static let mediumItalic = FontConvertible(name: "Inter28pt-MediumItalic", family: "Inter 28pt", path: "Inter_28pt-MediumItalic.ttf")
    public static let regular = FontConvertible(name: "Inter28pt-Regular", family: "Inter 28pt", path: "Inter_28pt-Regular.ttf")
    public static let semiBold = FontConvertible(name: "Inter28pt-SemiBold", family: "Inter 28pt", path: "Inter_28pt-SemiBold.ttf")
    public static let semiBoldItalic = FontConvertible(name: "Inter28pt-SemiBoldItalic", family: "Inter 28pt", path: "Inter_28pt-SemiBoldItalic.ttf")
    public static let thin = FontConvertible(name: "Inter28pt-Thin", family: "Inter 28pt", path: "Inter_28pt-Thin.ttf")
    public static let thinItalic = FontConvertible(name: "Inter28pt-ThinItalic", family: "Inter 28pt", path: "Inter_28pt-ThinItalic.ttf")
    public static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  public enum PlayfairDisplay {
    public static let black = FontConvertible(name: "PlayfairDisplay-Black", family: "Playfair Display", path: "PlayfairDisplay-Black.ttf")
    public static let blackItalic = FontConvertible(name: "PlayfairDisplay-BlackItalic", family: "Playfair Display", path: "PlayfairDisplay-BlackItalic.ttf")
    public static let bold = FontConvertible(name: "PlayfairDisplay-Bold", family: "Playfair Display", path: "PlayfairDisplay-Bold.ttf")
    public static let boldItalic = FontConvertible(name: "PlayfairDisplay-BoldItalic", family: "Playfair Display", path: "PlayfairDisplay-BoldItalic.ttf")
    public static let extraBold = FontConvertible(name: "PlayfairDisplay-ExtraBold", family: "Playfair Display", path: "PlayfairDisplay-ExtraBold.ttf")
    public static let extraBoldItalic = FontConvertible(name: "PlayfairDisplay-ExtraBoldItalic", family: "Playfair Display", path: "PlayfairDisplay-ExtraBoldItalic.ttf")
    public static let italic = FontConvertible(name: "PlayfairDisplay-Italic", family: "Playfair Display", path: "PlayfairDisplay-Italic.ttf")
    public static let medium = FontConvertible(name: "PlayfairDisplay-Medium", family: "Playfair Display", path: "PlayfairDisplay-Medium.ttf")
    public static let mediumItalic = FontConvertible(name: "PlayfairDisplay-MediumItalic", family: "Playfair Display", path: "PlayfairDisplay-MediumItalic.ttf")
    public static let regular = FontConvertible(name: "PlayfairDisplay-Regular", family: "Playfair Display", path: "PlayfairDisplay-Regular.ttf")
    public static let semiBold = FontConvertible(name: "PlayfairDisplay-SemiBold", family: "Playfair Display", path: "PlayfairDisplay-SemiBold.ttf")
    public static let semiBoldItalic = FontConvertible(name: "PlayfairDisplay-SemiBoldItalic", family: "Playfair Display", path: "PlayfairDisplay-SemiBoldItalic.ttf")
    public static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, italic, medium, mediumItalic, regular, semiBold, semiBoldItalic]
  }
  public enum SFPro {
    public static let black = FontConvertible(name: "SFPro-Black", family: "SF Pro", path: "SF-Pro.ttf")
    public static let blackItalic = FontConvertible(name: "SFPro-BlackItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let bold = FontConvertible(name: "SFPro-Bold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let boldItalic = FontConvertible(name: "SFPro-BoldItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let compressedBlack = FontConvertible(name: "SFPro-CompressedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedBold = FontConvertible(name: "SFPro-CompressedBold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedHeavy = FontConvertible(name: "SFPro-CompressedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedLight = FontConvertible(name: "SFPro-CompressedLight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedMedium = FontConvertible(name: "SFPro-CompressedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedRegular = FontConvertible(name: "SFPro-CompressedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedSemibold = FontConvertible(name: "SFPro-CompressedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedThin = FontConvertible(name: "SFPro-CompressedThin", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedUltralight = FontConvertible(name: "SFPro-CompressedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedBlack = FontConvertible(name: "SFPro-CondensedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedBold = FontConvertible(name: "SFPro-CondensedBold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedHeavy = FontConvertible(name: "SFPro-CondensedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedLight = FontConvertible(name: "SFPro-CondensedLight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedMedium = FontConvertible(name: "SFPro-CondensedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedRegular = FontConvertible(name: "SFPro-CondensedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedSemibold = FontConvertible(name: "SFPro-CondensedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedThin = FontConvertible(name: "SFPro-CondensedThin", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedUltralight = FontConvertible(name: "SFPro-CondensedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedBlack = FontConvertible(name: "SFPro-ExpandedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedBold = FontConvertible(name: "SFPro-ExpandedBold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedHeavy = FontConvertible(name: "SFPro-ExpandedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedLight = FontConvertible(name: "SFPro-ExpandedLight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedMedium = FontConvertible(name: "SFPro-ExpandedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedRegular = FontConvertible(name: "SFPro-ExpandedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedSemibold = FontConvertible(name: "SFPro-ExpandedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedThin = FontConvertible(name: "SFPro-ExpandedThin", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedUltralight = FontConvertible(name: "SFPro-ExpandedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let heavy = FontConvertible(name: "SFPro-Heavy", family: "SF Pro", path: "SF-Pro.ttf")
    public static let heavyItalic = FontConvertible(name: "SFPro-HeavyItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let light = FontConvertible(name: "SFPro-Light", family: "SF Pro", path: "SF-Pro.ttf")
    public static let lightItalic = FontConvertible(name: "SFPro-LightItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let medium = FontConvertible(name: "SFPro-Medium", family: "SF Pro", path: "SF-Pro.ttf")
    public static let mediumItalic = FontConvertible(name: "SFPro-MediumItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let regular = FontConvertible(name: "SFPro-Regular", family: "SF Pro", path: "SF-Pro.ttf")
    public static let regularItalic = FontConvertible(name: "SFPro-RegularItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let semibold = FontConvertible(name: "SFPro-Semibold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let semiboldItalic = FontConvertible(name: "SFPro-SemiboldItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let thin = FontConvertible(name: "SFPro-Thin", family: "SF Pro", path: "SF-Pro.ttf")
    public static let thinItalic = FontConvertible(name: "SFPro-ThinItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let ultralight = FontConvertible(name: "SFPro-Ultralight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let ultralightItalic = FontConvertible(name: "SFPro-UltralightItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, compressedBlack, compressedBold, compressedHeavy, compressedLight, compressedMedium, compressedRegular, compressedSemibold, compressedThin, compressedUltralight, condensedBlack, condensedBold, condensedHeavy, condensedLight, condensedMedium, condensedRegular, condensedSemibold, condensedThin, condensedUltralight, expandedBlack, expandedBold, expandedHeavy, expandedLight, expandedMedium, expandedRegular, expandedSemibold, expandedThin, expandedUltralight, heavy, heavyItalic, light, lightItalic, medium, mediumItalic, regular, regularItalic, semibold, semiboldItalic, thin, thinItalic, ultralight, ultralightItalic]
  }
  public static let allCustomFonts: [FontConvertible] = [FiraMono.all, Inter28pt.all, PlayfairDisplay.all, SFPro.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(macOS)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  public func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  public func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
    #elseif os(macOS)
    if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      register()
    }
    #endif
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
public extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
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
