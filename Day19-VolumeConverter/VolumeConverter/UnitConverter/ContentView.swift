//
//  ContentView.swift
//  UnitConverter
//
//  Created by Naïka Estriplet on 2025-09-12.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput: Double? = nil
    @State private var selectedUnit: String = "cups"
    @State private var selectedUnitToConvertTo: String = "gallons"
    @FocusState private var valueIsFocused: Bool
    
    let units = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    let unitToMilliliters = [
        "milliliters": 1.0,
        "liters": 1000.0,
        "cups": 236.588,
        "pints": 473.176,
        "gallons": 3785.41
    ]
    
    var convertedAmount: Double {
        let conversionFactor = unitToMilliliters[selectedUnit]!
        let inputValue = userInput ?? 0.0
        return (inputValue * conversionFactor) / unitToMilliliters[selectedUnitToConvertTo]!
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Starting Volume") {
                    TextField("Value", value: $userInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                    
                    Picker("InputUnit", selection: $selectedUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Convert To") {
                    Picker("Convert To", selection: $selectedUnitToConvertTo) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text("\(convertedAmount.formatted()) \(selectedUnitToConvertTo)")
                }
            }
            .navigationTitle("Volume Converter")
            .toolbar{
                if valueIsFocused {
                    Button("Done"){
                        valueIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
