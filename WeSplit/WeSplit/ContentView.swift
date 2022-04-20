//
//  ContentView.swift
//  WeSplit
//
//  Created by Daniel Maia dos Passos on 19/04/22.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 10
  @FocusState private var amountIsFocused: Bool
  
  let tipPercentages = [10, 15, 20, 25, 0]
  
  var totalPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)
    
    let tipValue = checkAmount / 100 * tipSelection
    let grantTotal = checkAmount + tipValue
    let amountPerPerson = grantTotal / peopleCount
    
    return amountPerPerson
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach (2..<100) {
              Text("\($0) People")
            }
          }
        }
        
        Section {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(tipPercentages, id: \.self) {
              Text($0, format: .percent)
            }
          }.pickerStyle(.segmented)
        } header: {
          Text("How much tip do you want to leave?")
        }
        
        Section {
          Text(totalPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
        }
        
        .navigationTitle("We split")
        .toolbar {
          ToolbarItemGroup(placement: .keyboard) {
            Button("Done") {
              amountIsFocused = false
            }
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
