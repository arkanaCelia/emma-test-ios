//
//  NativeAdManager.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 3/7/25.
//

import Foundation
import EMMA_iOS

class NativeAdManager: NSObject, EMMAInAppMessageDelegate {
    static let shared = NativeAdManager()
    
    var onAdReceived: ((EMMANativeAd?) -> Void)?
    
    func getNativeAd(templateId: String) {
        print("getting native ad")
        let nativeAdRequest = EMMANativeAdRequest()
        nativeAdRequest.templateId = templateId
        EMMA.inAppMessage(request: nativeAdRequest, withDelegate: self) // delegate
        print("finish getting native ad")
    }

    func onReceived(_ nativeAd: EMMANativeAd!) {
        print("NativeAd recibido: \(String(describing: nativeAd))")
        onAdReceived?(nativeAd)
    }
    
    func onShown(_ campaign: EMMACampaign!) {}
    func onHide(_ campaign: EMMACampaign!) {}
    func onClose(_ campaign: EMMACampaign!) {}
}
