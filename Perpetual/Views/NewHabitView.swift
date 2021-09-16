//
//  NewGoalView.swift
//  ninety days
//
//  Created by Caleb Elson on 7/2/20.
//

import SwiftUI
import Combine

// View to create new goals
// Requires at least one character to enable "save" button

struct NewHabitView: View {
    @State private var habitName: String = ""
    @Binding var showNewHabit: Bool
    // TODO: Make enum
    @State private var selectedRepetition: String = "Daily"
    @EnvironmentObject var habitsEnvironment: Habits
    
    
    var body: some View {
        NavigationView {
            VStack {
                // TODO: Ability to add image
                TextField("Enter habit name...", text: $habitName, onCommit: {
                    self.hideKeyboard()
                })
                    .multilineTextAlignment(.center)
                
                Picker("Repetition", selection: $selectedRepetition) {
                    Text("Daily")
                    Text("Weekly")
                    Text("Monthly")
                }
                Button(action: {
                    if habitName.count > 0 {
                        let habit = Habit()
                        habit.name = habitName
                        habit.repetition = selectedRepetition
                        
                        habitsEnvironment.addHabit(habit)
                        
                        showNewHabit = false
                    }
                }, label: {
                    Text("Save")
                })
                .disabled(habitName.count == 0)
            }
            .navigationBarItems(leading: Button(action: {
                showNewHabit = false
            }, label: {
                Text("Cancel")
            }))
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(showNewHabit: .constant(true))
    }
}
