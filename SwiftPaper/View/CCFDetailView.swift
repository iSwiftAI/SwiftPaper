//
//  CCFDetailView.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import SwiftUI
import SafariServices

struct CCFDetailView: View {
    @State private var presentingSafariView = false
    var model: CCFModel
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    VStack {
                        RankView(rank: model.rank, width: 100, height: 100)
                        Text(model.rank+" 类"+model.form)
                            .foregroundColor(.secondary)
                        if !model.abbreviation.isEmpty {
                            Text(model.abbreviation)
                                .font(.system(.title, design: .rounded))
                                .bold()
                        }
                        Text(model.fullName)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true).font(.title2)
                    }
                    Spacer()
                }
                .padding(.vertical)
            }.listRowBackground(Color.clear)
            Section {
                HStack {
                    Text("国际/中文")
                    Spacer()
                    Text(model.region).foregroundColor(.secondary)
                }
                HStack {
                    Text("领域")
                    Spacer()
                    Text(model.field)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("出版社")
                    Spacer()
                    Text(model.press)
                        .foregroundColor(.secondary)
                }
                
            }
            
            Button(action: {
                self.presentingSafariView = true
            }) {
                Label("访问链接", systemImage: "safari")
            }
            .safariView(isPresented: $presentingSafariView) {
                SafariView(
                    url: URL(string: model.site)!,
                    configuration: SafariView.Configuration(
                        entersReaderIfAvailable: false,
                        barCollapsingEnabled: true
                    )
                )
            }

            
        }
        .navigationTitle(Text("详细信息"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CCFDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CCFDetailView(model: CCFStore.placeholderCCF[0])
    }
}
