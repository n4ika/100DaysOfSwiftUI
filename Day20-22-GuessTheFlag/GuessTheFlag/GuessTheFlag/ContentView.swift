//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Naïka Estriplet on 2025-09-13.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var showingGameOver = false
    @State private var gameOverTitle = ""
    
    @State private var userScore: Int = 0
    
    @State private var numberOfQuestions: Int = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.4, green: 0.9, blue: 0.8), location: 0.0),
                .init(color: Color(red: 0.1, green: 0.5, blue: 0.6), location: 0.7)
            ], center: .leading, startRadius: 250, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 20, style: .continuous))
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(Color(red: 0.05, green: 0.2, blue: 0.3))
                    .font(.title.weight(.semibold))
                
                Text("Questions remaining: \(numberOfQuestions)")
                    .foregroundStyle(Color(red: 0.05, green: 0.2, blue: 0.3))
                    .font(.headline.weight(.semibold))
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert(gameOverTitle, isPresented: $showingGameOver) {
            Button("Play again", action: resetGame)
        } message: {
            Text("Your final score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        numberOfQuestions -= 1
        if numberOfQuestions == 0 {
            if number == correctAnswer {
                gameOverTitle = "Correct! That was the final question! GAME OVER!"
                userScore += 1
            } else {
                gameOverTitle = "Wrong! That's the flag of \(countries[number]). That was the final question! GAME OVER!"
                userScore -= 1
            }
            
            showingGameOver = true
        } else {
            if number == correctAnswer {
                scoreTitle = "Correct"
                userScore += 1
            } else {
                scoreTitle = "Wrong! That's the flag of \(countries[number])"
                userScore -= 1
            }
            
            showingScore = true
        }
            
        }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        userScore = 0
        numberOfQuestions = 8
        askQuestion()
    }
    }

#Preview {
    ContentView()
}
