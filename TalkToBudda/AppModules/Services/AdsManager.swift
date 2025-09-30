////
////  AdsManager.swift
////  TalkToBudda
////
////  Created by mac on 11/5/25.
////
//
//import GoogleMobileAds
//import UIKit
//
//enum AdType {
//    case banner
//    case interstitial
//    case native
//}
//
//class AdsManager: NSObject {
//    static let shared = AdsManager()
//    
//    // MARK: - Properties
//    private var interstitial: InterstitialAd?
//    private var nativeAd: NativeAd?
//    private var preloadRequest: Request?
//    private var isPreloading = false
//    
//    // MARK: - Ad Unit IDs
//    private let bannerAdUnitID = "ca-app-pub-xxx/yyy"
//    private let interstitialAdUnitID = "ca-app-pub-xxx/zzz"
//    private let nativeAdUnitID = "ca-app-pub-xxx/aaa"
//    
//    // MARK: - Banner Ad
//    func loadBannerAd(in view: UIView, rootViewController: UIViewController) {
//        let bannerView = BannerView(adSize: AdSizeBanner)
//        bannerView.adUnitID = bannerAdUnitID
//        bannerView.rootViewController = rootViewController
//        bannerView.load(Request())
//        view.addSubview(bannerView)
//        
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    /// Preload Interstitial Ads for better user experience
//    func preloadInterstitialAd() {
//        guard !isPreloading else { return }
//        isPreloading = true
//        preloadRequest = Request()
//        InterstitialAd.load(with: interstitialAdUnitID,
//                            request: preloadRequest!) { [weak self] ad, error in
//            self?.isPreloading = false
//            if let error = error {
//                print("Failed to preload interstitial ad: \(error.localizedDescription)")
//                return
//            }
//            self?.interstitial = ad
//            print("Interstitial Ad preloaded successfully.")
//        }
//    }
//    
//    func showInterstitialAd(from viewController: UIViewController) {
//        if let interstitial = interstitial {
//            interstitial.present(from: viewController)
//            preloadInterstitialAd()  // Preload the next one immediately
//        } else {
//            print("Interstitial Ad wasn't ready")
//            preloadInterstitialAd()
//        }
//    }
//    
//    // MARK: - Native Ad
//    func loadNativeAd(completion: @escaping (NativeAd?) -> Void) {
//        let request = Request()
//        AdLoader(adUnitID: nativeAdUnitID,
//                 rootViewController: nil,
//                 adTypes: [.native],
//                 options: nil)
//        .load(request)
//        
//    }
//}
//
//extension AdsManager: AdLoaderDelegate, NativeAdLoaderDelegate {
//    func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: Error) {
//        print("Failed to load native ad: \(error.localizedDescription)")
//    }
//    
//    func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
//        self.nativeAd = nativeAd
//        print("Native Ad loaded successfully.")
//    }
//}
