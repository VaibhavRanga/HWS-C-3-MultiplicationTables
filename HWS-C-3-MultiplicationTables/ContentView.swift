//
//  ContentView.swift
//  HWS-C-3-MultiplicationTables
//
//  Created by Vaibhav Ranga on 23/05/24.
//

import SwiftUI

struct ContentView: View {
    let pickerMaxNumbers = [4, 5, 6, 7, 8, 9]
    @State private var maxNumber = 4
    
    var multipliers = [2, 3, 4, 5, 6, 7, 8, 9].shuffled()
    
    @State private var num1 = 0
    @State private var num2 = 0
    
    static var option1 = 0
    static var option2 = 0
    static var option3 = 0
    
    @State private var options = [option1, option2, option3]
    
    @State private var showSettingsScreen = true
    
    @State private var showingAnswerAlert = false
    @State private var answerAlert = ""
    @State private var answerAlertMessage = ""
    
    @State private var score = 0
    @State private var totalQuestions = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if showSettingsScreen {
                    VStack {
                        Spacer()
                        
                        Form {
                            Picker("Select a number", selection: $maxNumber) {
                                ForEach(pickerMaxNumbers, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                        }
                        .pickerStyle(.automatic)
                        
                        Button("Start Game") {
                            showSettingsScreen = false
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                        
                        Spacer()
                        Spacer()
                    }
                } else {
                    VStack(spacing: 40) {
                        Spacer()
                        
                        HStack {
                            Text("\(num1)")
                                .font(.title)
                            Text("✕")
                            Text("\(num2)")
                                .font(.title)
                        }
                        
                        VStack {
                            Button("\(options[0])") {
                                checkAnswer(number: options[0])
                            }
                            .frame(width: 80, height: 40)
                            .foregroundStyle(.white)
                            .background(.mint)
                            .clipShape(.rect(cornerRadius: 15))
                            
                            Button("\(options[1])") {
                                checkAnswer(number: options[1])
                            }
                            .frame(width: 80, height: 40)
                            .foregroundStyle(.white)
                            .background(.mint)
                            .clipShape(.rect(cornerRadius: 15))
                            
                            Button("\(options[2])") {
                                checkAnswer(number: options[2])
                            }
                            .frame(width: 80, height: 40)
                            .foregroundStyle(.white)
                            .background(.mint)
                            .clipShape(.rect(cornerRadius: 15))
                        }
                        
                        Spacer()
                        
                        Text("Score: \(score)")
                        
                        Spacer()
                        
                    }
                    .onAppear {
                        askQuestion()
                    }
                }
                
            }
            .navigationTitle("MultiplicationTables")
            .toolbar {
                if !showSettingsScreen {
                    Button("Back", systemImage: "gearshape") {
                        loadMainScreen()
                    }
                }
            }
            .alert(answerAlert, isPresented: $showingAnswerAlert) {
                Button("Restart Game") {
                    restartGame()
                }
            } message: {
                Text(answerAlertMessage)
            }
        }
    }
    
    func checkAnswer(number: Int) {
        if number == ContentView.option1 {
            score += 1
        }
        
        totalQuestions += 1
        
        if totalQuestions == 5 {
            answerAlert = "Game Over"
            answerAlertMessage = "Your score is: \(score)/\(totalQuestions)"
            showingAnswerAlert = true
        } else {
            askQuestion()
        }
    }
    
    func askQuestion() {
        let numbers = (2...maxNumber).shuffled()
        print("\(maxNumber)")
        num1 = numbers.shuffled()[0]
        num2 = multipliers.shuffled()[0]
        
        ContentView.option1 = num1 * num2
        ContentView.option2 = [(num1 - 1), num1, (num1 + 1)].randomElement()! * [(num2 - 1), num2, (num2 + 1)].randomElement()!
        ContentView.option3 = numbers[2] * multipliers[2]
        
        options = [ContentView.option1, ContentView.option2, ContentView.option3].shuffled()
    }
    
    func restartGame() {
        score = 0
        totalQuestions = 0
        askQuestion()
    }
    
    func loadMainScreen() {
        score = 0
        totalQuestions = 0
        showSettingsScreen = true
    }
}

#Preview {
    ContentView()
}
