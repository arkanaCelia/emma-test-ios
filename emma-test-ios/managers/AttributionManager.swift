//
//  AttributionManager.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 2/7/25.
//

import Foundation
import Combine
import EMMA_iOS

class AttributionManager: NSObject, EMMAInstallAttributionDelegate {

    static let shared = AttributionManager()
    var attributionPublisher = PassthroughSubject<String, Never>()
    
    func requestAttributionInfo() {
        
        EMMA.installAttributionInfo(attributionDelegate: self)
        print("Solicitando attribution info a EMMA...")

    }

    // MARK: - EMMA Attribution Delegate
    func onAttributionReceived(_ attribution: EMMAInstallAttribution!) {
        guard let info = attribution else {
            print("rror getting attribution info")
            attributionPublisher.send("Error getting attribution info")
            return
        }
        print("Received attribution info: \(info)")
        attributionPublisher.send("Received attribution info: \(info)")
    }
}
