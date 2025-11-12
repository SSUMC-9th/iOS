// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

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

// MARK: - Asset Catalogs

public enum MegaAsset: Sendable {
  public enum Assets {
  public static let accentColor = MegaColors(name: "AccentColor")
    public static let ajjulsu = MegaImages(name: "ajjulsu")
    public static let appleLogo = MegaImages(name: "appleLogo")
    public static let background = MegaImages(name: "background")
    public static let boss = MegaImages(name: "boss")
    public static let bottomSumFaceImg = MegaImages(name: "bottomSumFaceImg")
    public static let bottomSumMonoImg = MegaImages(name: "bottomSumMonoImg")
    public static let brutails = MegaImages(name: "brutails")
    public static let conclave = MegaImages(name: "conclave")
    public static let f1 = MegaImages(name: "f1")
    public static let face = MegaImages(name: "face")
    public static let filmMobileorder = MegaImages(name: "film-mobileorder")
    public static let filmReel = MegaImages(name: "film-reel")
    public static let filmSofa = MegaImages(name: "film-sofa")
    public static let kakaoLogo = MegaImages(name: "kakaoLogo")
    public static let knife = MegaImages(name: "knife")
    public static let megaLogo = MegaImages(name: "megaLogo")
    public static let megaboxLogo = MegaImages(name: "megaboxLogo")
    public static let mickey = MegaImages(name: "mickey")
    public static let monono = MegaImages(name: "monono")
    public static let mononoWolf = MegaImages(name: "mononoWolf")
    public static let movieDetailPoster = MegaImages(name: "movieDetailPoster")
    public static let naverLogo = MegaImages(name: "naverLogo")
    public static let pinMap = MegaImages(name: "pin-map")
    public static let snowWhite = MegaImages(name: "snowWhite")
    public static let theFall = MegaImages(name: "theFall")
    public static let theRoses = MegaImages(name: "theRoses")
    public static let toystory = MegaImages(name: "toystory")
    public static let umcLogo = MegaImages(name: "umcLogo")
    public static let whiplash = MegaImages(name: "whiplash")
    public static let yadang = MegaImages(name: "yadang")
  }
  public enum Colors {
  public static let blue00 = MegaColors(name: "blue00")
    public static let blue01 = MegaColors(name: "blue01")
    public static let blue02 = MegaColors(name: "blue02")
    public static let blue03 = MegaColors(name: "blue03")
    public static let blue04 = MegaColors(name: "blue04")
    public static let blue05 = MegaColors(name: "blue05")
    public static let blue06 = MegaColors(name: "blue06")
    public static let blue07 = MegaColors(name: "blue07")
    public static let blue08 = MegaColors(name: "blue08")
    public static let blue09 = MegaColors(name: "blue09")
    public static let gray00 = MegaColors(name: "gray00")
    public static let gray01 = MegaColors(name: "gray01")
    public static let gray02 = MegaColors(name: "gray02")
    public static let gray03 = MegaColors(name: "gray03")
    public static let gray04 = MegaColors(name: "gray04")
    public static let gray05 = MegaColors(name: "gray05")
    public static let gray06 = MegaColors(name: "gray06")
    public static let gray07 = MegaColors(name: "gray07")
    public static let gray08 = MegaColors(name: "gray08")
    public static let gray09 = MegaColors(name: "gray09")
    public static let purple00 = MegaColors(name: "purple00")
    public static let purple01 = MegaColors(name: "purple01")
    public static let purple02 = MegaColors(name: "purple02")
    public static let purple03 = MegaColors(name: "purple03")
    public static let purple04 = MegaColors(name: "purple04")
    public static let purple05 = MegaColors(name: "purple05")
    public static let purple06 = MegaColors(name: "purple06")
    public static let purple07 = MegaColors(name: "purple07")
    public static let purple08 = MegaColors(name: "purple08")
    public static let purple09 = MegaColors(name: "purple09")
  }
  public enum PreviewAssets {
  }
}

// MARK: - Implementation Details

public final class MegaColors: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public var color: Color {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIColor: SwiftUI.Color {
      return SwiftUI.Color(asset: self)
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension MegaColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: MegaColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: MegaColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct MegaImages: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: MegaImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: MegaImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: MegaImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftformat:enable all
// swiftlint:enable all
