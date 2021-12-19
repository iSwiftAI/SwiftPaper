//
//  CCFRow.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import SwiftUI

struct CCFRow: View {
    @State var model: CCFModel
    
    var body: some View {
        HStack {
            VStack {
                RankView(rank: model.rank)
                Text(LocalizedStringKey(model.form))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading) {
                if !model.abbreviation.isEmpty {
                    Text(model.abbreviation)
                        .font(.system(.title, design: .rounded))
                        .bold()
//                        .padding([.bottom], 2)
                }
                Text(model.fullName)
                    .lineLimit(2)
//                Spacer()
                Group {
                    Text(model.press)
                    Text(LocalizedStringKey(model.field)).lineLimit(2)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
        }
        
    }
}

struct CCFRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CCFRow(model: CCFStore.placeholderCCF[0])
        }
        
    }
}
