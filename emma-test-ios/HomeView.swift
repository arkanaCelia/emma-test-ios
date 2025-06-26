//
//  ContentView.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 26/6/25.
//


import SwiftUI

struct HomeView: View {
    
    // language var
    @State private var selectedLanguage = "es"
    
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
                    Text("Simulate a register, a login or startSession. If this last button is not enabled, session is started automatically opening the app.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    HStack{
                        Button("Register") {
                            //TODO: implementar simulación de registro
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Login") {
                            //TODO: implementar simulación de login
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Start Session") {
                            //TODO: Implementar simulacion de startsession + deshabilitar boton si ya se inició + cambiar texto boton
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    
                    // Transactions
                    Text("EMMA allows you to measure any transaction or purchase made in your app.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.customGrey)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    HStack{
                        Button("Start Order") {
                            //TODO: implementar startorder
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Add Product") {
                            //TODO: implementar addproduct
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        
                    }
                    
                    HStack{
                        Button("Cancel Order") {
                            //TODO: implementar cancelorder
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                        Button("Track Order") {
                            //TODO: implementar trackorder
                        }
                        .padding()
                        .background(Color.emmaGreen)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        
                    }
                    
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
                        //TODO: implementar trackingevent
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
                
                Spacer()  // Para empujar los elementos hacia arriba
                .padding()
            }// end of VStack principal
                
        }// end of scrollview
            
    }//end of body
        
}

