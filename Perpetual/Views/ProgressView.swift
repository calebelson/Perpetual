//
//  ProgressView.swift
//  ninety days
//
//  Created by Caleb Elson on 7/1/20.
//

import SwiftUI

// ProgressView generates the rings view in HomeView
// Shows progress towards completion for every habit
// Circles are filled based on the values from AddTodayView
// Currently generates random values

struct ProgressView: View {
    @EnvironmentObject var habitsEnvironment: Habits
    //@State var refresh = false
    @State var filledCircleColor = Color.clear
    @State var emptyCircleColor = Color.clear
    var habitID = UUID()
    let colorManager = ColorManager()

    var body: some View {
        VStack {
            //Text(String(refresh)).hidden()
            let scoresGrid = createGrid(habitID: habitID)

            ForEach(scoresGrid.indices, id: \.self) { row in
                HStack {
                    let row = scoresGrid[row]
                    
                    ForEach(row.indices, id: \.self) { score in
                        let score = row[score].score
                        
                        switch score {
                        case 0...15:
                            Ring(progress: 1.0, thickness: 1.0)
                                .foregroundColor(emptyCircleColor)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.5)) {
                                        self.emptyCircleColor = Color.gray
                                    }
                                }
                        case 16...85:
                            Ring(progress: 1.0, thickness: 1.0)
                                .foregroundColor(colorManager.scoreColor(score))
                                //.animation(.easeInOut(duration: 1.0))
                        default:
                            Circle()
                                .foregroundColor(colorManager.scoreColor(score))
//                                .onAppear {
//                                    withAnimation(.easeInOut(duration: 1.0)) {
//                                        self.filledCircleColor = Color(.sRGB, red: (score/100)*1.5, green: 0.25*(100-score)/100, blue: (100-score)/100, opacity: 1)
//                                    }
//                                }
                        }
                    }
                    .frame(width: 20, height: 20)
                    .padding(.all, -3)
                    .onTapGesture {
                        filledCircleColor = Color.clear
                        emptyCircleColor = Color.clear
                        //refresh.toggle()
                    }
                }
            }
        }
    }
    
    private func sortedScores(habitID: UUID) -> [Scores] {
        let habit = habitsEnvironment.getHabit(habitID: habitID)
        
        return habit.scores.sorted(by: { $0.date < $1.date })
    }
    
    // Creates array of arrays out of scores for this habit
    // Max of 10 scores per sub array
    private func createGrid(habitID: UUID) -> [[Scores]] {
        let sorted = habitsEnvironment.getHabit(habitID: habitID).scores.sorted(by: { $0.date < $1.date })
        let rowLength = 10
        
        return stride(from: sorted.startIndex, to: sorted.endIndex, by: rowLength).map { Array(sorted[$0..<min($0 + rowLength, sorted.count)]) }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
