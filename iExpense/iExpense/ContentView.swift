//
//  ContentView.swift
//  iExpense
//
//  Created by Yugantar Jain on 12/05/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI
import Combine

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
class Expenses: ObservableObject {
        
    var items: [ExpenseItem] {
        didSet {
            print("abdswbdweiudg")
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    init() {
        print("wefewiofnweoi")
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            print("hy")
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                print("abcd")
                self.items = decoded
                print(self.items)
                return
            }
        }

        self.items = []
    }
}

struct ContentView: View {
    @State private var showingAddExpense = false

    @ObservedObject var expenses = Expenses()

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            
                            if item.amount < 10 {
                                Text("$\(item.amount)")
                                    .foregroundColor(.green)
                            } else {
                                Text("$\(item.amount)")
                                    .foregroundColor(.blue)
                            }
                            
                        }
                    }
                    .onDelete(perform: expenses.removeItems)
                }
                .navigationBarTitle("iExpense")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showingAddExpense.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                )
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
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
