//
//  HabitModel.swift
//  ninety days
//
//  Created by Caleb Elson on 7/14/21.
//

import SwiftUI

class Habits: ObservableObject {
    init() {
        self.habits = []
        
        loadData()
    }
    
    @Published var habits: [Habit]
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "habits")
            
            loadData()
        }
    }
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
        print("habit appended", habits, "\n\n")
        for habit in habits {
            print("name: ", habit.name, "uuid: ", habit.id, "repetition: ", habit.repetition, "scores: ", habit.scores, habit.created)
        }
        
        save()
    }
    
    func addScore(score: Double, habit: Habit) {
        habit.scores.append(
            Scores(date: Date(), score: score)
        )
        
        save()
    }
    
    // TODO: Rearchitect change/save habit
    func changeHabit() {
        save()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "habits") {
            if let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
                self.habits = decoded
                
                return
            }
        }
    }
    
    func getHabit(habitID: UUID) -> Habit {
        guard let habit = habits.first(where: { $0.id == habitID }) else {
            fatalError("Can't find habit in array")
        }
                 
        return habit
    }
    
    func deleteHabit(element: IndexSet, habitID: UUID) {
        let habit = getHabit(habitID: habitID)
        
        
        
        habit.scores.remove(atOffsets: element)
                
        save()
    }
    
    func removeAllHabits() {
        habits.removeAll()
        save()
    }
}


class Habit: Codable, Identifiable {
    private(set) var id = UUID()
    var name: String = ""
    var repetition: String = ""
    var scores: [Scores] = []
    private(set) var created = Date()
}

struct Scores: Codable, Identifiable {
    private(set) var id = UUID()
    var date: Date
    var score: Double
}
