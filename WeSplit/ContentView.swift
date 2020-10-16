//
//  ContentView.swift
//  WeSplit
//
//  Created by Joy Liu on 29/09/20.
//

import SwiftUI

enum Move: String, CaseIterable {
    
    case paper = "🖐"
    case scissor = "✌️"
    case rock = "👊"
    
    var wonBy: Move {
        switch self {
        case .paper:
            return .scissor
        case .scissor:
            return .rock
        case .rock:
            return .paper
        }
    }
    
    var loseBy: Move {
        return Self.allCases.first(where: { $0.wonBy == self })!
    }
}

struct ContentView: View {
    
    var moves = Move.allCases
    
    @State var computerShould: Bool = [true, false].randomElement()!
    @State var computerMove: Move = Move.allCases.randomElement()!
    
    @State var userMoveChosen: Bool = false
    @State var getsRight: Bool = false
    
    @State var choice: String = Move.paper.rawValue
    
    var titleSuffix: String {
        return computerShould ? "win" : "lose"
    }
    
    var alertButtonTitle: String {
        return self.getsRight ? "Yeah" : "Nah"
    }
    
    var alertButtonText: String {
        return self.getsRight ? "You did well" : "Try again"
    }
    
    var body: some View {
        
        NavigationView {

            Form {
                
                Section(header: Text("Computer choose")) {
                    HStack {
                        Spacer()
                        Text(computerMove.rawValue).font(.largeTitle)
                        Spacer()
                        VStack {
                            Text("Hint")
                            Text(computerShould ? computerMove.loseBy.rawValue : computerMove.wonBy.rawValue)
                        }.font(.caption)
                    }.padding()
                }
                
                Section(header: Text("Computer wants to")) {
                    HStack {
                        Spacer()
                        Text("\(titleSuffix)").font(.largeTitle)
                        Spacer()
                    }.padding()
                }
                
                Section(header: Text("Choose your move")) {
                    HStack {
                        
                        Spacer()
                        
                        ForEach(moves, id: \.self) { move in
                            
                            Button(action: {
                                self.getsRight = self.checkResult(move)
                                self.userMoveChosen = true
                            }, label: {
                                Text(move.rawValue).font(.largeTitle)
                            }).buttonStyle(BorderlessButtonStyle()).padding()
                            Spacer()
                        }
                        
                    }.padding()
                }
                
            }.alert(isPresented: $userMoveChosen, content: {
                
                Alert(
                    title: Text(alertButtonTitle),
                    message: Text(alertButtonText),
                    primaryButton: .default(Text("Ok"), action: {
                        self.computerShould = [true, false].randomElement()!
                        self.computerMove = moves.randomElement()!
                    }), secondaryButton: .cancel())
            })

            .navigationTitle("Let me \(titleSuffix)")
        }
    }
    
    func checkResult(_ moveChosen: Move) -> Bool {
        
        print("\n👓 checking result, \n\t computer choose: \(computerMove.rawValue)\n\t user choose \(moveChosen.rawValue)...")
        
        if self.computerShould {
            let isRight = self.computerMove.loseBy == moveChosen
            print(isRight)
            return isRight
        } else {
            let isRight = self.computerMove.wonBy == moveChosen
            print(isRight)
            return isRight
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
