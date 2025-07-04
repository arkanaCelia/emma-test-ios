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
    
    // Sheet managing for userInfo, Nativead and coupons
    enum ActiveSheet: Identifiable {
        case userInfo
        case nativeAd
        case coupons

        var id: String {
            switch self {
            case .userInfo: return "userInfo"
            case .nativeAd: return "nativeAd"
            case .coupons: return "coupons"
            }
        }
    }

    @Published var activeSheet: ActiveSheet? = nil
    
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
    
    // Selected language
    @Published var selectedLanguage = "es"
    
    // In-App messages
    @Published var nativeAd: EMMANativeAd? = nil
    @Published var coupons: [EMMACoupon] = []
    @Published var coupon: EMMACoupon? = nil


    
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
    
    //                   //
    // --- Functions --- //
    //                   //


    // --- MARK: Session
    
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
    
    // --- MARK: Behavior
    
    func registerUser() {
        EMMA.registerUser(userId: userid, forMail: mail, andExtras: nil)
        showToast(message: "Register test: User \(userid) with email \(mail) registered.")
    }
    
    func loginUser() {
        EMMA.loginUser(userId: userid, forMail: mail, andExtras: nil)
        showToast(message: "Login test: User \(userid) with email \(mail) logged in.")
    }
    
    // --- MARK: Transactions
    
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
    
    // --- MARK: Customized event
    
    func trackEvent() {
        let eventToken = "83fdb9ae1fbdd2f8f95eb5d426b2e63e"
        EventManager.shared.trackCustomEvent(token: eventToken)
        showToast(message: "Tracking event with token \(eventToken)")
    }
    
    // --- MARK: User properties: TAG
    
    func setAge() {
        if !userAge.isEmpty{
            EMMA.trackExtraUserInfo(info: ["AGE": userAge])
            showToast(message: "Age set as a TAG, with value = \(userAge)")
        } else {
            showToast(message: "Please enter an age")
        }
    }
    
    // --- MARK: User info
    
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
        let deviceId = EMMA.deviceId()
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
                self.activeSheet = .userInfo
            }
        }
    }
    
    func setCustomerID(){
        EMMA.setCustomerId(customerId: customerId)
        showToast(message: "Customer ID set to: \(customerId)")
    }
    
    // --- MARK: Attribution
    
    func requestAttribution() {
        AttributionManager.shared.requestAttributionInfo()
    }
    
    // --- MARK: Set user language
    func setLanguage(){
        EMMA.setUserLanguage(selectedLanguage)
        showToast(message: "Language changed to \(selectedLanguage)")
    }
    
    // --- MARK: InApp Messages
    
    // NativeAd
    
    func getNativeAd(templateId: String) {
        print("getNativeAd inits")
        NativeAdManager.shared.onAdReceived = { [weak self] nativeAd in
            DispatchQueue.main.async {
                if let ad = nativeAd {
                    self?.nativeAd = ad
                    self?.activeSheet = .nativeAd
                    print("if inits")
                } else {
                    self?.showToast(message: "No NativeAd found")
                    print("else init")
                }
            }
        }
        NativeAdManager.shared.getNativeAd(templateId: templateId)
        print("getNativeAd finish")
    }
    
    func onReceived(_ nativeAd: EMMANativeAd!) {
        guard let nativeAd = nativeAd else {
            self.showToast(message: "No NativeAd found")
            return
        }
        print("Received NativeAd with idPromo: \(nativeAd.idPromo)")
        EMMA.sendImpression(campaignType: .campaignNativeAd, withId: String(nativeAd.idPromo))
        DispatchQueue.main.async {
            self.nativeAd = nativeAd
        }
    }
    
    func onShown(_ campaign: EMMACampaign!) {}
    func onHide(_ campaign: EMMACampaign!) {}
    func onClose(_ campaign: EMMACampaign!) {}
    
    // Start View
    func getStartView() {
        let startViewinAppRequest = EMMAInAppRequest(type: .Startview)
        // Optional. You can filter by label
        //startViewinAppRequest.label = "<LABEL>"
        /*
         By default Startview presents on UIApplication.shared.delegate?.window?.rootViewController
         You can customize this behavior uncommenting following line
        */
        //EMMA.setRootViewController(UIViewController!)
        EMMA.inAppMessage(request: startViewinAppRequest)
    }
    
    // AdBall
    func getAdBall() {
        let adballRequest = EMMAInAppRequest(type: .Adball)
        EMMA.inAppMessage(request: adballRequest)
    }
    
    // Banner
    func getBanner() {
        let bannerRequest = EMMAInAppRequest(type: .Banner)
        EMMA.inAppMessage(request: bannerRequest)
    }
    
    // Strip
    func getStrip() {
        let stripRequest = EMMAInAppRequest(type: .Strip)
        EMMA.inAppMessage(request: stripRequest)
    }
    
    // Coupons
    func getCoupons() {
        CouponManager.shared.onCouponsReceived = { [weak self] coupons in
            DispatchQueue.main.async {
                if let firstCoupon = coupons.first {
                    self?.coupon = firstCoupon
                    self?.activeSheet = .coupons
                } else {
                    self?.showToast(message: "No coupon available")
                }
            }
        }
        
        CouponManager.shared.onError = { [weak self] in
            self?.showToast(message: "Error retrieving coupons")
        }
        
        CouponManager.shared.getCoupons()
    }
    
    // Dynamic Tab Bar
    func getDynamicTabBar() {
        // You must define your UITabBarController
        // Uncomment following line!
        // EMMA.setPromoTabBarController(UITabBarController!)

        // Sets default promo tab index if not defined in EMMA Platform
        //EMMA.setPromoTabBarIndex(index: 5)

        // Sets a tab bar item to be shown if not defined in EMMA Platform
        // EMMA.setPromoTabBarItem(UITabBarItem!)
        let dynamicTabBarRequest = EMMAInAppRequest(type: .PromoTab)
        EMMA.inAppMessage(request: dynamicTabBarRequest)
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
