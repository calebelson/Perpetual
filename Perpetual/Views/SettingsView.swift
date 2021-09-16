//
//  SettingsView.swift
//  ninety days
//
//  Created by Caleb Elson on 7/2/20.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    @EnvironmentObject var habitsEnvironment: Habits
    @State var showAbout = false
    @State var deleteAllAlert = false
    @State var showNewHabit = false
    @State var currentIcon = "AppIconImage"
    private let iconManager = IconManager()
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    if habitsEnvironment.habits.count == 0 {
                        Button(action: {
                            showNewHabit.toggle()
                        }, label: {
                            Text("Add a habit")
                        })
                            .sheet(isPresented: $showNewHabit) {
                                NewHabitView(showNewHabit: $showNewHabit)
                            }
                        
                    } else {
                        ForEach(habitsEnvironment.habits) { habit in
                            NavigationLink {
                                HabitDetailView(habitID: habit.id)
                            } label: {
                                HStack {
                                    Image(systemName: "timelapse")
                                    Text(habit.name)
                                }
                            }
                        }
                    }
                }
                
                Section() {
                    Button(action: {
                        showAbout.toggle()
                    }, label: {
                        Text("About")
                    }).sheet(isPresented: $showAbout) {
                        AboutView()
                    }
                }
                
                Section() {
                    NavigationLink {
                        IconSelectView()
                    } label: {
                        HStack {
                            Image(uiImage: UIImage(named: currentIcon) ?? UIImage())
                                .cornerRadius(12)
                            Text("Change icon")
                        }
                        .onAppear {
                            currentIcon = iconManager.getIcon().imageName
                        }
                    }
                }
                
                Section() {
                    Button(action: {
                        deleteAllAlert = true
                    }, label: {
                        Text("Delete all habits")
                            .foregroundColor(.red)
                    })
                }
            }
            .alert(isPresented: $deleteAllAlert) {
                Alert(title: Text("Are you sure?"), message: Text(
                    "Are you sure you want to delete all habits? This cannot be undone"
                ), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete all"), action: habitsEnvironment.removeAllHabits))
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .navigationBarItems(leading: Button(action: {
                showSettings = false
            }, label: {
                Text("Done")
            }), trailing: Button(action: {
                // TODO: Enable reordering
            }, label: {
                Text("Edit")
            }))
        }
    }
    
    // TODO: Enable reordering
    func move(from source: IndexSet, to destination: Int) {
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SettingsView(showSettings: .constant(true)).preferredColorScheme($0)
        }
    }
}
