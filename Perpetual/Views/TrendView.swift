//
//  TrendView.swift
//  ninety days
//
//  Created by Caleb Elson on 6/30/20.
//

import SwiftUI

// TrendView generates the bar graphs in HomeView
// Shows historical data for every day recorded for every habit
// Color and height vary based on the values from AddTodayView
// Currently generates random values

struct TrendView: View {
    @EnvironmentObject var habitsEnvironment: Habits
    let habitID: UUID

    var body: some View {
        let sortedScores = sortedScores(habitID: habitID)
        
        VStack {
            ScrollView(.horizontal) {
                ScrollViewReader { scrollView in
                    HStack {
                        ForEach(sortedScores) { score in
                            VStack {
                                Spacer()
                                
                                // TODO: Year indicator
                                let rectValues = colorAndHeight(score: score.score)
                                
                                Rectangle()
                                    .fill(rectValues.color)
                                    .frame(width: 20, height: rectValues.height)
                                

                                
                                Text(monthAndDay(date: score.date))
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .frame(height: 18)
                                    .foregroundColor(rectValues.color)
                            }
                        }
                    }
                    .padding(.all)
//                    .onAppear {
//                        // TODO: - Change to last in the data set
//                        //scrollView.scrollTo(sortedScores(habitID: habitID).endIndex - 1)
//                    }
                }
            }
        }
    }
    
    private func sortedScores(habitID: UUID) -> [Scores] {
        let habit = habitsEnvironment.getHabit(habitID: habitID)
        
        return habit.scores.sorted(by: { $0.date < $1.date })
    }
}

func colorAndHeight(score: Double) -> (color: Color, height: CGFloat) {
    let color = ColorManager().scoreColor(score)
    let height = CGFloat(score)

    return (color, height)
}

func monthAndDay(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    let monthDay = dateFormatter.string(from: date)
    
    return monthDay
}

struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TrendView(habitID: UUID())
        }
    }
}
