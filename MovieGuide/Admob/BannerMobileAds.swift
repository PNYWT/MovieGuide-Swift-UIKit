//
//  MobileAds.swift
//  MovieGuide
//
//  Created by CallmeOni on 15/6/2566 BE.
//

import Foundation
import AppTrackingTransparency
import AdSupport
import GoogleMobileAds

class UnitIDAds{
    static let banner = "ca-app-pub-3940256099942544/2934735716"
    static let native = "ca-app-pub-3940256099942544/3986624511"
}

protocol BannerMobileAdsDelegate{
    func addBanner(banner:GADBannerView)
    func failLoadBanner()
}

class BannerMobileAds:NSObject{
    
    static let shared = BannerMobileAds()
    var delegate:BannerMobileAdsDelegate?
    var bannerView: GADBannerView!
    
    func startBanner(){
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = UnitIDAds.banner
        bannerView.rootViewController = AppDelegate.shareViewController()
        bannerView.delegate = self
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        bannerView.load(GADRequest())
    }
    
    func requestIDFA() {
        DispatchQueue.main.async {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status{
                case .notDetermined:
                    print("Don't save imei")
                case .restricted:
                    print("Don't save imei")
                case .denied:
                    print("Don't save imei")
                case .authorized:
                    print("save imei and send analytic")
                @unknown default:
                    print("Don't save imei")
                }
                self.startBanner()
            })
        }
    }
}

extension BannerMobileAds:GADBannerViewDelegate{
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
        self.delegate?.addBanner(banner: bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        self.delegate?.failLoadBanner()
    }
}
