//
//  EventManager.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 1/7/25.
//

import Foundation
import EMMA_iOS

class EventManager: NSObject, EMMARequestDelegate {
    
    static let shared = EventManager()  
    
    func trackCustomEvent(token: String) {
        let request = EMMAEventRequest(token: token)
        request.attributes = ["test_attribute": "test_value"]
        request.requestDelegate = self
        request.customId = "test_event_celia"
        
        EMMA.trackEvent(request: request)
    }
    
    // EMMARequestDelegate
    
    func onStarted(_ id: String!) {
        print("Event \(id ?? "") started")
    }
    
    func onSuccess(_ id: String!, containsData data: Bool) {
        print("Event \(id ?? "") succeeded")
    }
    
    func onFailed(_ id: String!) {
        print("Event \(id ?? "") failed")
    }
}

