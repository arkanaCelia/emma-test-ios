//
//  HomeViewModel.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 30/6/25.
//

import Foundation
import EMMA_iOS
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var sessionStarted: Bool = false
    
    // Toast managing
    @Published var showToast = false
    @Published var toastMessage = ""
    
    // Behavior
    let userid = "Celia"
    let mail = "celia@emma.io"
    
    // Transactions
    @Published var transactionStarted = false
    @Published var isProductAdded = false
    @Published var quantity: Float = 0.0
    @Published var totalPrice: Float = 0.0
    let orderId = "Order_ID_test"
    let customerId = "Customer_ID_test"
    let productId = "Product_ID_test"
    let productName = "Product_name_test"
    
    // Tags
    @Published var userAge: String = ""
    
    // User info
    @Published var setcustomerId: String = ""
    @Published var userInfo: [String: Any] = [:]
    @Published var showingUserInfo = false

    
    private var cancellables = Set<AnyCancellable>()

    init() {
        checkSession()
        AttributionManager.shared.attributionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.toastMessage = message
                self?.showToast = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self?.showToast = false
                }
            }
            .store(in: &cancellables)
         
    }

    // --- Functions --- //
    
    // Session
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
    
    // Behavior
    func registerUser() {
        EMMA.registerUser(userId: userid, forMail: mail, andExtras: nil)
        showToast(message: "Register test: User \(userid) with email \(mail) registered.")
    }
    
    func loginUser() {
        EMMA.loginUser(userId: userid, forMail: mail, andExtras: nil)
        showToast(message: "Login test: User \(userid) with email \(mail) logged in.")
    }
    
    // Transactions
    func startOrder() {
        transactionStarted = true
        EMMA.startOrder(orderId: orderId, andCustomer: customerId, withTotalPrice: totalPrice, withExtras: nil, assignCoupon: nil)
        
        showToast(message: "Order started with order id: \(orderId)  and customer id: \(customerId)." )
    }
    
    func addProduct() {
        isProductAdded = true
        quantity += 1
        totalPrice = quantity * 10.0
        EMMA.addProduct(productId: productId, andName: productName, withQty: quantity, andPrice: totalPrice, withExtras: nil)
        showToast(message: "Product added with id: \(productId) and name: \(productName)")
    }
    
    func cancelOrder() {
        transactionStarted = false
        isProductAdded = false
        quantity = 0.0
        totalPrice = 0.0
        
        EMMA.cancelOrder(orderId: orderId)
        showToast(message: "Order with id: \(orderId) cancelled.")
    }
    
    func trackOrder() {
        EMMA.trackOrder()
        showToast(message: "Tracking order. Total products purchased: \(Int(quantity)). Total price: \(Int(totalPrice))€")
        transactionStarted = false
        isProductAdded = false
        quantity = 0.0
        totalPrice = 0.0
    }
    
    // Customized event
    func trackEvent() {
        let eventToken = "83fdb9ae1fbdd2f8f95eb5d426b2e63e"
        EventManager.shared.trackCustomEvent(token: eventToken)
        showToast(message: "Tracking event with token \(eventToken)")
    }
    
    // User properties: TAG
    
    func setAge() {
        if !userAge.isEmpty{
            EMMA.trackExtraUserInfo(info: ["AGE": userAge])
            showToast(message: "Age set as a TAG, with value = \(userAge)")
        } else {
            showToast(message: "Please enter an age")
        }
    }
    
    // User info
    
    func getUserID(){
        EMMA.getUserId { (user_id) in
                guard let uid = user_id else {
                    self.showToast(message: "Error getting user id")
                    return
                }
            self.showToast(message: "Your EMMA USER ID is \(uid)")
            }
    }
    
    func getDeviceID(){
        var deviceId = EMMA.deviceId()
        showToast(message: "Your device ID is \(deviceId)")
    }
    
    func getAllUserInfo(){
        EMMA.getUserInfo { (user_profile) in
            guard let profile = user_profile else {
                self.showToast(message: "Error getting user profile")
                return
            }
            
            // to dictionary
            var info: [String: Any] = [:]
            for (key, value) in profile {
                info["\(key)"] = value
            }
            
            DispatchQueue.main.async {
                self.userInfo = info
                self.showingUserInfo = true
            }
        }
    }
    
    func setCustomerID(){
        EMMA.setCustomerId(customerId: customerId)
        showToast(message: "Customer ID set to: \(customerId)")
    }
    
    // Attribution
    func requestAttribution() {
        AttributionManager.shared.requestAttributionInfo()
    }
    
    
    // Manual toast in the view
    func showToast(message: String) {
        toastMessage = message
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showToast = false
        }
    }


    
}
