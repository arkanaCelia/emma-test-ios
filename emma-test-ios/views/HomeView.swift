//
//  ContentView.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 26/6/25.
//


import SwiftUI
import EMMA_iOS

struct HomeView: View {
    
    // --- variables --- //
    @StateObject private var viewModel = HomeViewModel()
    
    // Toast to watch events on UI
    @State private var showToast = false
    @State private var toastMessage = ""
    
    // Language
    @State private var selectedLanguage = "es"
    
    // Transactions
    @State private var transactionStarted = false
    @State private var isProductAdded = false
    @State private var quantity: Float = 0.0
    @State private var totalPrice: Float = 0.0
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {  // Espacio entre elementos verticales
                
            // --- Home banner --- //
                
                Image("emmaBanner")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top)
                
            
            // --- Behavior --- //
                
                VStack {
                    Text("Behavior events")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("These events are common to all applications, and are automatically created when EMMA integration is performed. Try with these buttons some of the events.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    // Register + Login + StartSession
                    Text("Simulate a register or a login in the app.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    HStack{
                        
                        //btnRegister
                        Button("Register") {
                            var userid = "Celia"
                            var mail = "celia@emma.io"
                            
                            EMMA.registerUser(userId: userid, forMail: mail, andExtras: nil)
                            
                            showToast(message: "Register test: User \(userid) with email \(mail) registered.")

                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        //btnLogin
                        Button("Login") {
                            var userid = "Celia"
                            var mail = "celia@emma.io"
                            
                            EMMA.loginUser(userId: userid, forMail: mail, andExtras: nil)
                            
                            showToast(message: "Login test: User \(userid) with email \(mail) logged in.")
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        //btnStartsession
                        Button(viewModel.sessionStarted ? "Session started" : "Start session") {
                            viewModel.startSessionIfNeeded()
                        }
                        .padding()
                        .background(viewModel.sessionStarted ? Color.gray : Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .disabled(viewModel.sessionStarted)
                        
                    }
                    
                    // Transactions
                    let orderId = "Order_ID_test"
                    let customerId = "Customer_ID_test"
                    let productId = "Product_ID_test"
                    let productName = "Product_name_test"
                    
                    Text("EMMA allows you to measure any transaction or purchase made in your app.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    HStack{
                        
                        //btnStartOrder
                        Button("Start Order") {
                            transactionStarted = true
                            EMMA.startOrder(orderId: "Order_ID", andCustomer: "Customer_ID", withTotalPrice: totalPrice, withExtras: nil, assignCoupon: nil)
                            
                            showToast(message: "Order started with order id: \(orderId)  and customer id: \(customerId)." )
                        }
                        .padding()
                        .background(transactionStarted ? Color.gray : Color.emmaGreen)
                        .disabled(transactionStarted)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Add Product") {
                            isProductAdded = true
                            quantity += 1
                            totalPrice = quantity * 10.0
                            EMMA.addProduct(productId: productId, andName: productName, withQty: quantity, andPrice: totalPrice, withExtras: nil)
                            showToast(message: "Product added with id: \(productId) and name: \(productName)")
                        }
                        .padding()
                        .foregroundColor(.black)
                        .background(transactionStarted ? Color.emmaGreen : Color.gray)
                        .disabled(!transactionStarted)
                        .cornerRadius(10)
                        
                    }
                    
                    HStack{
                        
                        //btnCancelOrder
                        Button("Cancel Order") {
                            transactionStarted = false
                            isProductAdded = false
                            quantity = 0.0
                            totalPrice = 0.0
                            
                            EMMA.cancelOrder(orderId: orderId)
                            showToast(message: "Order with id: \(orderId) cancelled.")
                        }
                        .padding()
                        .background(transactionStarted ? Color.emmaGreen : Color.gray)
                        .disabled(!transactionStarted)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        //btnTrackOrder
                        Button("Track Order") {
                            
                            EMMA.trackOrder()
                            showToast(message: "Tracking order. Total products purchased: \(Int(quantity)). Total price: \(Int(totalPrice))€")
                            transactionStarted = false
                            isProductAdded = false
                            quantity = 0.0
                            totalPrice = 0.0
                        }
                        .padding()
                        .background(isProductAdded ? Color.emmaGreen : Color.gray)
                        .disabled(!isProductAdded)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    
                    // table show transaction
                    HStack(alignment: .top) {
                        // Column 1: Product name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Product name")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Text(productName)
                                .font(.body)
                                .foregroundColor(Color.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        // Column 2: Quantity
                        VStack(alignment: .center, spacing: 8) {
                            Text("Quantity")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Text("\(Int(quantity))")
                                .font(.body)
                                .foregroundColor(Color.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                        // Column 3: Price
                        VStack(alignment: .trailing, spacing: 8) {
                            Text("Price")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Text("\(Int(totalPrice))")
                                .font(.body)
                                .foregroundColor(Color.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding()
                    .opacity(transactionStarted ? 1 : 0)
                    
                }
                
                
            // --- Custom Events --- //
                
                VStack {
                    Text("Customized Event")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("These are all those actions or sections within the application that are unique to your application. You must configure a Customized Event on EMMA and get the Event token there.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Clic on the button to track a customized event.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    Button("Track event") {
                        var eventToken = "83fdb9ae1fbdd2f8f95eb5d426b2e63e"
                        EventManager.shared.trackCustomEvent(token: eventToken)
                        showToast(message: "Tracking event with token \(eventToken)")
                        
                    }
                    .padding()
                    .background(Color.emmaGreen)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                }
            
                
            // --- User properties: TAG --- //
                
                VStack {
                    Text("User properties (TAG)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("With this method you can update or add extra parameters in order to get better segmentation in the Users with tag filtering.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    // Register + Login + StartSession
                    Text("Change your age tag, and obtain all user tags")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    HStack{
                        Button("Set age") {
                            //TODO: implementar logica para añadir la edad que el usuario escriba
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("See user tags") {
                            //TODO: implementar logica para mostrar en la app los tags del usuario
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    
                }
                
                
            // --- User info --- //
                
                VStack {
                    Text("User info")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("We can retrieve the EMMA user ID, the device ID or set the customer ID independently of the login/registration.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Get the info with these buttons, or set the customer ID manually.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    HStack{
                        Button("Get user ID") {
                            //TODO: mostrar user id
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Get device ID") {
                            //TODO: mostrar device ID
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    HStack{
                        Button("Set customer ID") {
                            //TODO: implementar lógica para introducir un ID de customer
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Get all user info") {
                            //TODO: implementar lógica para mostrar toda la info del usuario
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    
                }
                
                
            // --- Set user language --- //
                
                VStack {
                    Text("Set language")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("This method allows overwriting the default language of the device to set a custom language to be used in all SDK requests.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Manually sets the user's preferred language.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    Picker(selection: $selectedLanguage, label: Text("Language")) {
                        Text("Spanish").tag("es")
                        Text("English").tag("en")
                        Text("French").tag("fr")
                        Text("German").tag("de")
                        Text("Italian").tag("it")
                        Text("Chinese").tag("zh-Hans")
                    }
                    .pickerStyle(.menu)
                    
                    Button("Set language") {
                        //TODO: implementar cambiar idioma (refrescar pantalla?)
                    }
                    .padding()
                    .background(Color.emmaGreen)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                }
                
            // --- Installation attribution --- //
                    
                VStack {
                    Text("Attribution info")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("It is possible to get the installation attribution data for each user")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        
                    Text("Clic on the button to get attribution info.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    Button("View attribution info") {
                        //TODO: implementar obtener info de atribucion
                    }
                    .padding()
                    .background(Color.emmaGreen)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                        
                    }
                
                
            // --- In-App Messages --- //
                
                VStack {
                    Text("InApp Messages")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("EMMA includes 8 different communication formats that you can integrate to impact your users on iOS.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("You must configure them in EMMA and be sure they are ACTIVE to see them in this test. Clic on the buttons to see each message in-app.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    HStack{
                        Button("NativeAd") {
                            //TODO: implementar vista que infle un nativead
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("StartView") {
                            //TODO: implementar startview
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    HStack{
                        Button("AdBall") {
                            //TODO: implementar adball
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Banner") {
                            //TODO: implementar banner
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    HStack{
                        Button("Strip") {
                            //TODO: implementar strip
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Coupon") {
                            //TODO: implementar vista que infle un coupon
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    HStack{
                        Button("DynamicTab") {
                            //TODO: implementar dynamictab
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("CustomPlugins") {
                            //TODO: implementar customplugin (?)
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    
                }
                
                Spacer()  // pushing elements up
                .padding()
                
            }// end of VStack principal
            
            .onAppear {
                //waits 1sec after the view appears to check if the session is started
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.checkSession()
                }
                
                
            }
                
        }// end of scrollview
        
        .overlay( // showing toast on the view
            Group {
                if showToast {
                    ToastView(message: toastMessage)
                        .padding(.bottom, 60)
                }
            },
            alignment: .bottom
        )

            
    }//end of body
    
    // --- other functions --- //
    
    // show toast
    func showToast(message: String) {
        toastMessage = message
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showToast = false
        }
    }

    
        
}

