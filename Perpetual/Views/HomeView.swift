//
//  HomeView.swift
//  ninety days
//
//  Created by Caleb Elson on 6/30/20.
//

import SwiftUI

struct HomeView: View {
    @State var showSettings = false
    @State var showNewHabit = false
    @State var addToday: Habit?
    @StateObject var habitsEnvironment = Habits()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habitsEnvironment.habits) { habit in
                    Section(header: Text(habit.name)) {
                        VStack {
                            Text("\(habit.name)\n\(monthDayYear(date: habit.created))")
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding(.all)
                            if habit.scores.count != 0 {
                                //                                Divider()
                                //                                ProgressView(habits: habits, habitID: habit.id, scores: habit.scores)
                                //                                    .padding(.bottom)
                                
                                Divider()
                                TrendView(habitID: habit.id)
                                    .padding(.all)
                            }
                            
                            // TODO: Calculate whether today is mising from goal's data
                            Divider()
                            Button(action: {
                                addToday = habit
                                
                            }, label: {
                                Text("Add Today")
                                    .foregroundColor(.blue)
                            })
                            
                        }
                        // Reduces touch response to just the button
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .textCase(nil)
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            
            .sheet(item: $addToday,
                   onDismiss: didDismiss) { _ in
                AddTodayView(habit: $addToday)
            }
                   .navigationTitle("Habits")
            
                   .navigationBarItems(
                    leading:
                        Button(action: {
                            showNewHabit.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        }).sheet(isPresented: $showNewHabit) {
                            NewHabitView(showNewHabit: $showNewHabit)
                        },
                    trailing:
                        Button(action: {
                            showSettings.toggle()
                        }, label: {
                            Image(systemName: "gear")
                        })
                        .sheet(isPresented: $showSettings) {
                            SettingsView(showSettings: $showSettings)
                        }
                   )
        }
        // Avoids layout errors from navigationTitle
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(habitsEnvironment)
    }
    
    func didDismiss() {
        print("\ndismissed\n")
        addToday = nil
    }
    
    private func monthDayYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let monthDay = dateFormatter.string(from: date)
        
        return monthDay
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeView().preferredColorScheme($0)
        }
    }
}
