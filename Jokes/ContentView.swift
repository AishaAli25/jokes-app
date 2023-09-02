//
//  ContentView.swift
//  Jokes
//
//  Created by Aisha Ali on 11/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    var jokes = [
        
        Joke(setup: "Did you hear about the claustrophobic astronaut?", punchline: "He just needed a little space."),
        Joke(setup: "Why don’t scientists trust atoms?", punchline: "Because they make up everything."),
        Joke(setup: "What did the left eye say to the right eye?", punchline: "Between you and me, something smells. hahaa"),
        Joke(setup: "What do you call a fake noodle?", punchline: "An impasta!"),
        Joke(setup: "What did the shark say when he ate the clownfish?", punchline: "This tastes a little funny."),
        Joke(setup: "What do you call a fish wearing a bowtie?", punchline: "Sofishticated!"),
        Joke(setup: "How does the man in the moon get his hair cut?", punchline: "Eclipse it."),
        Joke(setup: "What happens to an illegally parked frog?", punchline: "It gets toad away."),
        Joke(setup: "What do you call a bear with no teeth?", punchline: "A gummy bear."),
        
    ]
    
    @State private var showPunchline = false
    @State private var currentJokeIndex = 1
    @State private var isFeedbackPresented = false
    
    @State private var displaySheet: Bool = false
    @State private var isFeedbackPositive: Bool = false
    
    @State private var punchlineSize = 0.1
    @State private var punchlineRotation = Angle.zero
    @State private var punchlineOpacity = 0.0
    @State private var tapToContinueOffset = 100.0
    
    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    if showPunchline {
                        currentJokeIndex += 1
      // this method could also be used but it's longer
                        //                        if currentJokeIndex == jokes.count {
                        //                            currentJokeIndex = 0
                        //                        }
                        showPunchline = false
                        isFeedbackPresented = true
                    }
                }
            
            VStack {
        // % shows the remainder, so it brings it back to the 1st joke (shorter method)
                Text(jokes[currentJokeIndex % jokes.count].setup)
                    .padding()
                    .font(.title)
                    .multilineTextAlignment(.center)
                Button {
                    print("Shows the joke")
                    withAnimation {
                        showPunchline = true
                    }
                } label: {
                    Text("*What*? **_Tell me_**!!")
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.yellow)
                        .cornerRadius(10)
                        .font(.title2)
                }
                .padding(30)
                
                
                if showPunchline {
                    Text(jokes[currentJokeIndex % jokes.count].punchline)
                        .padding()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .scaleEffect(punchlineSize)
                        .rotationEffect(punchlineRotation)
                        .opacity(punchlineOpacity)
                        .onAppear {
                            withAnimation(.spring()) {
                                punchlineSize = 1
                                punchlineRotation = Angle(degrees: 720)
                                punchlineOpacity = 1
                                tapToContinueOffset = 0
                            }
                        }
                        .onDisappear {
                            punchlineSize = 0.1
                            punchlineRotation = .zero
                            punchlineOpacity = 0
                            tapToContinueOffset = 100
                        }
                    
                    Text("Tap to continue")
                        .font(.title3)
                        .foregroundColor(.blue)
                        .italic()
                        .padding()
                        .opacity(punchlineOpacity)
                        .offset(y: tapToContinueOffset)
                }
            }
            .padding()
        }
        .alert("Did you like the last joke?", isPresented: $isFeedbackPresented) {
            Button("👍") {
                print("Good!")
                displaySheet = true
                isFeedbackPositive = true
            }
            Button("👎") {
                print("Bad joke")
                displaySheet = true
                isFeedbackPositive = false
            }
        }
        .sheet(isPresented: $displaySheet) {
            FeedbackResponseView(isFeedbackPositive: isFeedbackPositive)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
