//
//  ContentView.swift
//  WeSplit
//
//  Created by Joy Liu on 29/09/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: String = ""
    
    private var originalAmount: Double { Double(amount) ?? 0 }
    
    let tips: [Double] = [15, 20, 25, 30]
    
    @State private var selectedTips: Int = 1
    
    private var tipAmount: Double {
        return originalAmount * tips[selectedTips] * 0.01
    }
            
    var body: some View {
        
            
            Form {
                
                Section(header: Text("Bill Amount")) {
                    TextField("Enter something", text: $amount).keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tips Percentage", selection: $selectedTips) {
                        ForEach(0..<tips.count) {
                            Text("\(tips[$0], specifier: "%.2f")")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Text("Tips to pay: $ \(tipAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Total"), footer: Text("Thanks for your purchase!")) {
                    Text("You have to pay: $ \(originalAmount+tipAmount, specifier: "%.2f")")
                }
                
                ZStack {
                    Color.green
                    Text("BYE")
                }
                
            
            
            
           
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
