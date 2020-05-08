//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Yugantar Jain on 07/05/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var userScore = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0 ..< 3)
    let color1 = UIColor.init(named: "color1") ?? UIColor.red
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                
                VStack {
                    Text("Tap the flag of")
                        .font(.title)
                        .foregroundColor(Color.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(Color.secondary)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.gray, lineWidth: 1))
                            .shadow(color: .black, radius: 10)
                    }
                }
                
                Spacer()
                
                Text("\(userScore)")
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
            
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            self.userScore += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(userScore)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
