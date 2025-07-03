//
//  NativeAdView.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 3/7/25.
//

import SwiftUI
import EMMA_iOS

struct NativeAdView: View {
    var nativeAd: EMMANativeAd

    var body: some View {
        let content = nativeAd.nativeAdContent as? [String: AnyObject]
        let title = content?["Title"] as? String ?? "No Title"
        let imageUrl = content?["Main picture"] as? String ?? ""
        let textBody = content?["Body"] as? String ?? ""

        ScrollView {
            VStack(spacing: 20) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)

                if let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    .cornerRadius(10)
                }
                Text(textBody)
                    .font(.body)

            }
            .padding()
        }
        .onAppear {
            EMMA.sendImpression(campaignType: .campaignNativeAd, withId: String(nativeAd.idPromo))
            
        }
    }
}
