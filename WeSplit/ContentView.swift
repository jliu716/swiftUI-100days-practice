//
//  ContentView.swift
//  WeSplit
//
//  Created by Joy Liu on 29/09/20.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    fileprivate func kelvinFromCelcius(_ value: Double) -> Double {
        return celciusMeasure.converted(to: .kelvin).value
    }
    
    fileprivate func celciusFromKelvin(_ value: Double) -> Double {
        return kelvinMeasure.converted(to: .celsius).value
    }
            
    @State var celcius = ""
    @State var kelvin = ""
    
    var celciusValue: Double { return Double(celcius) ?? 0 }
    
    var kelvinValue: Double { return Double(kelvin) ?? 0}
    
    var celciusMeasure: Measurement<UnitTemperature> {
        return Measurement(value: celciusValue, unit: UnitTemperature.celsius)
    }
    
    var kelvinMeasure: Measurement<UnitTemperature> {
        return Measurement(value: kelvinValue, unit: UnitTemperature.kelvin)
    }
    
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section {
                    HStack {
                        Text("Celcius")
                        Spacer(minLength: 10)
                        TextField("Degree", text: $celcius).keyboardType(.decimalPad).onChange(of: celcius, perform: { value in
                            if kelvinFromCelcius(celciusValue) != self.kelvinValue {
                                self.kelvin = String(format: "%g", kelvinFromCelcius(celciusValue))
//                                let test: LocalizedStringKey = "\(kelvinFromCelcius(celciusValue), specifier: "%g")"
                            }
                        })
                    }.multilineTextAlignment(.trailing)
                }
                
                Section {
                    HStack {
                        Text("Kelvin")
                        Spacer(minLength: 10)
                        TextField("Degree", text: $kelvin).keyboardType(.decimalPad).onChange(of: kelvin, perform: { value in
                            if celciusFromKelvin(kelvinValue) != self.celciusValue {
                                self.celcius = String(format: "%g", celciusFromKelvin(kelvinValue))
                            }
                        })
                    }.multilineTextAlignment(.trailing)
                }
            }
        
            .navigationBarTitle("Temperature Converter", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
