//
//  HabitDetailView.swift
//  HabitDetailView
//
//  Created by Caleb Elson on 7/28/21.
//

import SwiftUI

struct HabitDetailView: View {
    @EnvironmentObject var habitsEnvironment: Habits
    @State var addToday: Habit?
    let habitID: UUID
        
    var body: some View {
        let habit = habitsEnvironment.getHabit(habitID: habitID)
        
        Form {
            Section(header: Text("Habit name")) {
                TextField("Enter habit name", text: nameBinding(habitID: habitID))
            }
            
            Section(header: Text("Scores")) {
                if habit.scores.count == 0 {
                    Button(action: {
                        addToday = habit
                        
                    }, label: {
                        Text("No scores yet - add today's!")
                            .foregroundColor(.blue)
                    })
                        .sheet(item: $addToday, onDismiss: { addToday = nil }) { _ in
                            AddTodayView(habit: $addToday)
                        }
                } else {
                    
                    ForEach(habit.scores.sorted(by: { $0.date < $1.date })) { score in
                        DisclosureGroup(content: {
                            VStack {
                                let scoreBinding = scoreBinding(habitID: habitID, for: score)

                                DatePicker(selection: scoreBinding.date, label: {
                                    Text("\(score.score)")
                                })
                                    .labelsHidden()
                                
                                // TODO: Fix crash on delete with score displayed for last element in scores
                                Slider(value: scoreBinding.score, in: 0...100, step: 1)
                            }
                        }, label: {
                            Text("Date: \(monthDayYear(date: score.date)), Score: \(Int(score.score))")
                        })
                    }
                    .onDelete { indexSet in
                        self.habitsEnvironment.deleteHabit(element: indexSet, habitID: habitID)
                    }
                }
            }
        }
        .navigationTitle(Text(habitsEnvironment.getHabit(habitID: habitID).name))
        .onDisappear(perform: {
            habitsEnvironment.changeHabit()
        })
    }
    
    private func monthDayYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let monthDay = dateFormatter.string(from: date)
        
        return monthDay
    }
    
    private func nameBinding(habitID: UUID) -> Binding<String> {
        guard let habitIndex = habitsEnvironment.habits.firstIndex(where: { $0.id == habitID }) else {
            fatalError("Can't find habit in array")
        }
        
        return $habitsEnvironment.habits[habitIndex].name
    }
    
    private func scoreBinding(habitID: UUID, for score: Scores) -> Binding<Scores> {
        guard let habitIndex = habitsEnvironment.habits.firstIndex(where: { $0.id == habitID }) else {
            fatalError("Can't find habit in array")
        }
        
        guard let scoreIndex = habitsEnvironment.habits[habitIndex].scores.firstIndex(where: { $0.id == score.id }) else {
            fatalError("Can't find habit in array")
        }
        
        return $habitsEnvironment.habits[habitIndex].scores[scoreIndex]
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitDetailView(habitID: UUID()).preferredColorScheme($0)
        }
    }
}
