//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Naïka Estriplet on 2025-09-18.
//

import SwiftUI

struct ContentView: View {
    @State private var possibleMoves = ["✊", "✋", "✌️"]
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var winOrLose = Bool.random()
    
    @State private var playerScore: Int = 0
    @State private var roundCount: Int = 10
    
    @State private var showingGameOver = false
    @State private var gameOverTitle = ""
    
    @State private var lastMoveCorrect = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack {
                    Text("Your goal").textCase(.uppercase)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 5)
                    Text(winOrLose ? "Try to WIN 🏆" : "Try to LOSE 🥲")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(winOrLose ? .green : .red)
                }
                .frame(width: 300)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))
                
                VStack(spacing: 20) {
                                    ForEach(0..<3, id: \.self) { index in
                                        Button {
                                            playerTapped(index)
                                        } label: {
                                            Text("\(["Rock", "Paper", "Scissors"][index]) (\(possibleMoves[index]))")
                                        }
                                        .frame(width: 260, height: 60)
                                        .background(.blue)
                                        .foregroundStyle(.white)
                                        .clipShape(.rect(cornerRadius: 20, style: .continuous))
                                    }
                                }
                                .frame(width: 300)
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(.rect(cornerRadius: 10))
                
                VStack(spacing: 20) {
                    VStack {
                        Text("Computer's last choice").textCase(.uppercase)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("\(possibleMoves[computerChoice])")
                            .font(.largeTitle)
                        
                        if roundCount < 10 {  // Only show feedback after first move
                            Text(lastMoveCorrect ? "Correct! ✅" : "Wrong ❌")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(lastMoveCorrect ? .green : .red)
                                .padding(.top, 5)
                        }
                    }
                    .frame(width: 300)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    
                    HStack(spacing: 30) {
                        Text("Round: \(11 - roundCount) of 10")
                        Text("Score: \(playerScore)")
                    }
                    .frame(width: 300)
                    .font(.headline.bold())
                    .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.4, blue: 0.6), location: 0.0),
                    .init(color: Color(red: 0.2, green: 0.6, blue: 0.7), location: 0.4),
                    .init(color: Color(red: 0.3, green: 0.7, blue: 0.8), location: 0.7),
                    .init(color: Color(red: 0.4, green: 0.8, blue: 0.9), location: 1.0)
                ], center: .bottomLeading, startRadius: 80, endRadius: 700)
            )
            .navigationTitle("Rock, Paper, Scissors")
            .navigationBarTitleDisplayMode(.inline)
            .alert(gameOverTitle, isPresented: $showingGameOver) {
                Button("Play again!", action: resetGame)
            } message: {
                Text("Your final score is \(playerScore)")
            }
        }
    }
    
    func playerTapped(_ playerChoice: Int) {
        let playerWon = checkIfPlayerWon(playerChoice: playerChoice, computerChoice: computerChoice)
        
        let isCorrect = (winOrLose && playerWon) || (!winOrLose && !playerWon)
        playerScore += isCorrect ? 1 : -1
        lastMoveCorrect = isCorrect
        
        roundCount -= 1
        
        if roundCount == 0 {
            gameOverTitle = " 🪨, 📃, ✂️ is Over!"
            showingGameOver = true
        } else {
            computerChoice = Int.random(in: 0...2)
            winOrLose.toggle()
        }
    }
    
    func checkIfPlayerWon(playerChoice: Int, computerChoice: Int) -> Bool {
        return (playerChoice == 0 && computerChoice == 2) ||
               (playerChoice == 1 && computerChoice == 0) ||
               (playerChoice == 2 && computerChoice == 1)
    }
    
    func resetGame() {
        playerScore = 0
        roundCount = 10
        computerChoice = Int.random(in: 0...2)
        winOrLose = Bool.random()
        lastMoveCorrect = false
    }
}

#Preview {
    ContentView()
}
