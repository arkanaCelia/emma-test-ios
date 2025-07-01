//
//  HomeViewModel.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 30/6/25.
//

import Foundation
import EMMA_iOS

class HomeViewModel: ObservableObject {
    
    @Published var sessionStarted: Bool = false

    init() {
        checkSession()
    }

    func checkSession() {
        sessionStarted = EMMA.isSessionStarted()
        print("VM - sessionStarted: \(sessionStarted)")
    }

    func startSessionIfNeeded() {
        if !sessionStarted {
            let config = EMMAConfiguration()
            config.sessionKey = "3DBF55A0B7BC550874edfbac6d5dc49f8"
            EMMA.startSession(with: config)

            // wait 0,5 secs before checking if EMMA session is started
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.checkSession()
            }
        }
    }
}
