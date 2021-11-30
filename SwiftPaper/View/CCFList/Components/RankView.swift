//
//  RankView.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import SwiftUI

struct RankView: View {
    var rank: String
    @State var width: Double = 70
    @State var height: Double = 70
    
    let cornerRadiusRate: CGFloat = 0.2237
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradientColors[rank]!)
                .frame(width: width, height: width)
                .clipShape(RoundedRectangle(cornerRadius: width * cornerRadiusRate, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: width * cornerRadiusRate, style: .continuous)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 0.5)
                )
            Text(rank)
                .font(.system(size: width / 7 * 4, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .shadow(color: .secondary, radius: 3, x: 1, y: 1)
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView(rank: "A")
        RankView(rank: "B")
        RankView(rank: "C")
    }
}

let LinearGradientColors: [String: LinearGradient] = [
    "A": LinearGradient(gradient: .init(colors: [.yellow, .red]),
                        startPoint:  .leading, endPoint:  .trailing),
    "B": LinearGradient(gradient: .init(colors: [.green, .blue]),
                        startPoint:  .leading, endPoint:  .trailing),
    "C": LinearGradient(gradient: .init(colors: [.indigo, .pink]),
                        startPoint:  .leading, endPoint:  .trailing)
]
