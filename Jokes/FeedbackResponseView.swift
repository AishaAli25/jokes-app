//
//  FeedbackResponseView.swift
//  Jokes
//
//  Created by Aisha Ali on 11/07/2023.
//

import SwiftUI

struct FeedbackResponseView: View {
    
    var isFeedbackPositive: Bool
    
    var body: some View {
       VStack {
           Image(isFeedbackPositive ? "happy" : "sad")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(width:350)
                .mask(Circle())
           Text(isFeedbackPositive ? "Awww!! Thank you so much! 🥺" : "Booo... Someone has a bad taste in jokes. 😔" )
               .foregroundColor(.red)
               .font(.title2)
               .bold()
               .multilineTextAlignment(.center)
               .padding()
       }
    }
}

struct FeedbackResponseView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackResponseView(isFeedbackPositive: true)
        FeedbackResponseView(isFeedbackPositive: false)
    }
}
