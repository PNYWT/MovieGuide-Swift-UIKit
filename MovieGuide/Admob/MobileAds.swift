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
}

protocol MobileAdsDelegate{
    func mobileAdsLoadSuccess(isSucc:Bool, bannerView:UIView?)
}

class MobileAds:NSObject{
    
    static let shared = MobileAds()
    var delegate:MobileAdsDelegate?
    var bannerView: GADBannerView!
    
    func addBannerToVC(VC:UIViewController){
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        bannerView.rootViewController = VC
    }
    
    func startBanner(){
        bannerView.adUnitID = UnitIDAds.banner
        bannerView.delegate = self
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
            })
        }
    }
}

extension MobileAds:GADBannerViewDelegate{
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
        self.delegate?.mobileAdsLoadSuccess(isSucc: true, bannerView: bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        self.delegate?.mobileAdsLoadSuccess(isSucc: false, bannerView: nil)
    }
}
