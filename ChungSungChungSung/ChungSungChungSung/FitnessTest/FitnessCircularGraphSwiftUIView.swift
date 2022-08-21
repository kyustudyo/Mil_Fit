//
//  FitnessCircularGraphSwiftUIView.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/07.
//

import SwiftUI

struct RunningGraphSwiftUIView: View {
    @ObservedObject var graphData: GraphData
    var body: some View {
        ZStack {
            Circle()
                .stroke(.red.opacity(0.06), lineWidth: 10)
                .background(Color.clear)
                
            Circle()
                .trim(from: 0, to: graphData.rate)
                .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: -90))
                .background(Color.clear)
            
            Text("\(graphData.level)")
                .background(Color.clear)
                .foregroundColor(Color(CustomColor.red!))
        }.background(Color.clear)
    }
}

struct PushupGraphSwiftUIView: View {
    @ObservedObject var graphData: GraphData
    var body: some View {
        ZStack {
            Circle()
                .stroke(.purple.opacity(0.06), lineWidth: 10)
                .background(Color.clear)
                
            Circle()
                .trim(from: 0, to: graphData.rate)
                .stroke(.purple, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: -90))
                .background(Color.clear)
            
            Text("\(graphData.level)")
                .background(Color.clear)
                .foregroundColor(Color(CustomColor.strongPurple!))
        }.background(Color.clear)
    }
}

struct SitupGraphSwiftUIView: View {
    @ObservedObject var graphData: GraphData
    var body: some View {
        ZStack {
            Circle()
                .stroke(.blue.opacity(0.06), lineWidth: 10)
                .background(Color.clear)
                
            Circle()
                .trim(from: 0, to: graphData.rate)
                .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: -90))
                .background(Color.clear)
            
            Text("\(graphData.level)")
                .background(Color.clear)
                .foregroundColor(Color(CustomColor.blue!))
        }.background(Color.clear)
    }
}
//struct RunningGraphSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunningGraphSwiftUIView()
//    }
//}
