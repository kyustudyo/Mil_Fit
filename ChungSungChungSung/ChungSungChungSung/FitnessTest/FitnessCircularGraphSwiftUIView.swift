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
                .trim(from: 0, to: 0.8)
                .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: -90))
                .background(Color.clear)
            
            Text("특급")
                .background(Color.clear)
                .foregroundColor(Color.red)
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
                .trim(from: 0, to: 0.5)
                .stroke(.purple, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: -90))
                .background(Color.clear)
            
            Text("1급")
                .background(Color.clear)
                .foregroundColor(.purple)
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
                .trim(from: 0, to: 0.3)
                .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: -90))
                .background(Color.clear)
            
            Text("2급")
                .background(Color.clear)
                .foregroundColor(.blue)
        }.background(Color.clear)
    }
}
//struct RunningGraphSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunningGraphSwiftUIView()
//    }
//}
