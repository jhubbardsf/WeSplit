//
//  ContentView.swift
//  WeSplit
//
//  Created by Josh Hubbard on 1/20/20.
//  Copyright © 2020 YeetBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
//    @State private var numberOfPeople = 2
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var checkAmountReadable: Double {
        return Double(checkAmount) ?? 0
    }
    
    var checkTotal: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let checkTotal = orderAmount + tipAmount
        
        return checkTotal
    }
    
    var tipAmount: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipValue = orderAmount / 100 * tipSelection
        
        return tipValue
    }
    
    var totalPerPerson: Double {
        //TODO: Calculate the total per person here
//        let peopleCount = Double(numberOfPeople + 2)
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / (peopleCount ?? 0)
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                    //                    Picker("Number of people", selection: $numberOfPeople) {
                    //                        ForEach(2 ..< 100) {
                    //                            Text("\($0) people")
                    //                        }
                    //                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person:")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Check breakdown")) {
                    Text("Check: \(checkAmountReadable, specifier: "%.2f")")
                    Text("Tip: \(tipAmount, specifier: "%.2f")")
                    Text("Pre-split Total: \(checkTotal, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
