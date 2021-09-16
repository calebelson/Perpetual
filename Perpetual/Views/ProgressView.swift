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

//struct ProgressView: View {
//    @State var refresh = false
//    @State var filledCircleColor = Color.clear
//    @State var emptyCircleColor = Color.clear
//    @ObservedObject var habits = Habits()
//    var habitID = UUID()
//    var scores: [Scores] = []
//    
//    var body: some View {
//        VStack {
//            Text(String(refresh)).hidden()
//
//            ForEach(Range(0...(scores.count/10))) { row in
//
//                HStack {
//                    ForEach(0..<min(10, scores.count - row*10)) { column in                        
//                        switch scores[row*10 + column] {
//                        case 0...15:
//                            Ring(progress: 1.0, thickness: 1.0)
//                                .foregroundColor(emptyCircleColor)
//                                .onAppear {
//                                    withAnimation(.easeInOut(duration: 1.5)) {
//                                        self.emptyCircleColor = Color.gray
//                                    }
//                                }
//                        case 16...85:
//                            Ring(progress: Double(random.number/100), thickness: 1.5)
//                                .foregroundColor(random.color)
//                                .animation(.easeIn(duration: 2.5))
//                        default:
//                            Circle()
//                                .foregroundColor(filledCircleColor)
//                                .onAppear {
//                                    withAnimation(.easeInOut(duration: 1.0)) {
//                                        self.filledCircleColor = Color.red
//                                    }
//                                }
//                        }
//                    }
//                    .frame(width: 20, height: 20)
//                    .padding(.all, -3)
//                    .onTapGesture {
//                        filledCircleColor = Color.clear
//                        emptyCircleColor = Color.clear
//                        refresh.toggle()
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct ProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressView()
//    }
//}
