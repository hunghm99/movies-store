//
//  MoviesListView.swift
//  MoviesStore
//
//  Created by Hung Hoang on 9/1/22.
//

import SwiftUI

struct MoviesListView: View {
    
    var buttonTapped: (() -> Void)?
    
    private func angle(proxy: GeometryProxy) -> Double {
        let screenWidth = UIScreen.main.bounds.width
        let haftWidth = screenWidth / 2
        var angle: Double = 0
        let x = proxy.frame(in: .global).minX
        let diff = x + proxy.frame(in: .global).width / 2
        angle = 0.02 * (diff - haftWidth)
        return angle
    }
    
    private func getY(proxy: GeometryProxy) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let haftWidth = screenWidth / 2
        var position: CGFloat = 0
        let x = proxy.frame(in: .global).minX
        let diff = x + proxy.frame(in: .global).width / 2
        if(diff > haftWidth) {
            position = (haftWidth - diff) * 0.15
        } else {
            position = (diff - haftWidth) * 0.15
        }
        return -1*position
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<20) { num in
                    GeometryReader { proxy in
                        let angle = angle(proxy: proxy)
                        Image("poster")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 230)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .offset(x: 0, y: getY(proxy: proxy))
                            .rotationEffect(.degrees(angle))
                    }
//                    .background(Color.red)
                    .frame(width: 250, height: 400)
                    .padding(15)
                }
            }
            .padding(.bottom)
            .background(Color.red)
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
