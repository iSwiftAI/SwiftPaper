//
//  EmptyCCFView.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI

struct EmptyCCFView: View {
    
    var body: some View {
        VStack {
            Image("empty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                
            Text("这里空空如也，刷新一下，或者换个关键词或筛选条件再试试吧～")
                .font(.title2)
                .padding()
        }
        .padding()

    }
}

struct EmptyCCFView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCCFView()
    }
}
