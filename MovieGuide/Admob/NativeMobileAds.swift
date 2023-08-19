//
//  NativeMobileAds.swift
//  MovieGuide
//
//  Created by CallmeOni on 20/6/2566 BE.
//

import Foundation
import GoogleMobileAds

class NativeMobileAds:NSObject{
    
    static let shared = NativeMobileAds()
    var adLoader: GADAdLoader!
    var nativeAdView: GADNativeAdView!
    var heightConstraint: NSLayoutConstraint?
    
    //add native to subview Main
    func nativeAddsubview(viewMain:UIView){
        guard
            let nibObjects = Bundle.main.loadNibNamed("NativeView", owner: nil, options: nil),
            let adView = nibObjects.first as? GADNativeAdView
        else {
            assert(false, "Could not load nib file for adView")
        }
        
        nativeAdView = adView
        viewMain.addSubview(nativeAdView)
        let viewDictionary = ["_nativeAdView": adView]
        viewMain.translatesAutoresizingMaskIntoConstraints = false
        viewMain.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[_nativeAdView]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary as [String : Any])
        )
        viewMain.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[_nativeAdView]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary as [String : Any])
        )
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nativeAdView.leadingAnchor.constraint(equalTo: viewMain.leadingAnchor, constant: 0),
            nativeAdView.trailingAnchor.constraint(equalTo: viewMain.trailingAnchor, constant: 0),
            nativeAdView.topAnchor.constraint(equalTo: viewMain.topAnchor, constant: 0),
            nativeAdView.bottomAnchor.constraint(equalTo: viewMain.bottomAnchor, constant: 0)
        ])
        
        
    }
    
    //Load Native
    func loadNative(VC:UIViewController){
        let videoOptions:GADVideoOptions = GADVideoOptions.init()
        videoOptions.startMuted = true
        adLoader = GADAdLoader(adUnitID: UnitIDAds.native, rootViewController: VC,
                               adTypes: [ .native ], options: [ videoOptions ])
        adLoader.load(GADRequest())
        adLoader.delegate = self
    }
    
    func imageOfStars(from starRating: NSDecimalNumber?) -> UIImage? {
        guard let rating = starRating?.doubleValue else {
            return nil
        }
        if rating >= 5 {
            return UIImage(named: "stars_5")
        } else if rating >= 4.5 {
            return UIImage(named: "stars_4_5")
        } else if rating >= 4 {
            return UIImage(named: "stars_4")
        } else if rating >= 3.5 {
            return UIImage(named: "stars_3_5")
        } else {
            return nil
        }
    }
}

extension NativeMobileAds: GADNativeAdLoaderDelegate, GADNativeAdDelegate {
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        
        // Set ourselves as the native ad delegate to be notified of native ad events.
        nativeAd.delegate = self
        
        // Populate the native ad view with the native ad assets.
        // The headline and mediaContent are guaranteed to be present in every native ad.
        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
        
        // Some native ads will include a video asset, while others do not. Apps can use the
        // GADVideoController's hasVideoContent property to determine if one is present, and adjust their
        // UI accordingly.
        let mediaContent = nativeAd.mediaContent
        if mediaContent.hasVideoContent {
            // By acting as the delegate to the GADVideoController, this ViewController receives messages
            // about events in the video lifecycle.
            mediaContent.videoController.delegate = self
            print("Ad contains a video asset.")
        } else {
            print("Ad does not contain a video.")
        }
        
        // This app uses a fixed width for the GADMediaView and changes its height to match the aspect
        // ratio of the media it displays.
        if let mediaView = nativeAdView.mediaView, nativeAd.mediaContent.aspectRatio > 0 {
            heightConstraint = NSLayoutConstraint(
                item: mediaView,
                attribute: .height,
                relatedBy: .equal,
                toItem: mediaView,
                attribute: .width,
                multiplier: CGFloat(1 / nativeAd.mediaContent.aspectRatio),
                constant: 0)
            heightConstraint?.isActive = true
        }
        
        // These assets are not guaranteed to be present. Check that they are before
        // showing or hiding them.
        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView.bodyView?.isHidden = nativeAd.body == nil
//        nativeAdView.backgroundColor = .blue
        
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
        
        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.iconView?.isHidden = nativeAd.icon == nil
        
        (nativeAdView.starRatingView as? UIImageView)?.image = imageOfStars(from: nativeAd.starRating)
        nativeAdView.starRatingView?.isHidden = nativeAd.starRating == nil
        
        (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
        nativeAdView.storeView?.isHidden = nativeAd.store == nil
        
        (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
        nativeAdView.priceView?.isHidden = nativeAd.price == nil
        
        (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil
        nativeAdView.callToActionView?.isUserInteractionEnabled = false
        nativeAdView.nativeAd = nativeAd
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
    }
    
    func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
        // The native ad was shown.
        
    }
}

//videoController.delegate
extension NativeMobileAds: GADVideoControllerDelegate {
    func videoControllerDidEndVideoPlayback(_ videoController: GADVideoController) {
        
    }
}
