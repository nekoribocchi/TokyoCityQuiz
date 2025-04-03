//
//  LicenseView.swift
//  TokyoCityQuiz2
//
//  Created by nekoribocchi on 2025/04/03.
//


import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack{
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "chevron.left")
                                Text("戻る")
                                    .font(.potta(size: 20))
                            }
                            .foregroundColor(.r_Purple)
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .padding(.horizontal)
                    
                    Text("使用素材・開発者情報")
                        .font(.potta(size: 25))
                    
                    
                    List {
                        Section(header: Text("使用素材").font(.potta(size: 20))) {
                            LicenseItemView(
                                title: "曲名: ポン太は旅に出る",
                                subtitle: "作曲者：のる（DOVA-SYNDROME）",
                                linkTitle: "サイトを見る",
                                linkURL: "https://dova-s.jp/bgm/play21417.html"
                            )
                            
                            LicenseItemView(
                                title: "フォント名: Potta One",
                                subtitle: "GoogleFonts",
                                linkTitle: "サイトを見る",
                                linkURL: "https://fonts.google.com/specimen/Potta+One?lang=ja_Jpan"
                            )
                        }
                        
                        Section(header: Text("開発者について").font(.potta(size: 20))) {
                            LicenseItemView(
                                title: "名前：ねこりぼっち",
                                subtitle: "iOSアプリ開発者/イラストレーター",
                                linkTitle: "ポートフォリオを見る",
                                linkURL: "https://nekoribocchi.com"
                            )
                            LicenseItemView(
                                title: "X（旧Twitter）",
                                subtitle: "@nekoribocchi",
                                linkTitle: "X（旧Twitter）を見る",
                                linkURL: "https://x.com/nekoribocchi"
                            )
                        }
                        
                        Section(header: Text("他のアプリ").font(.potta(size: 20)))  {
                            LicenseItemView(
                                title: "CAFETAN",
                                subtitle: "駅カフェ検索アプリ",
                                linkTitle: "App Storeで見る",
                                linkURL: "https://apps.apple.com/jp/app/cafetan-%E3%82%AB%E3%83%95%E3%82%A7%E6%8E%A2%E7%B4%A2%E3%82%A2%E3%83%97%E3%83%AA/id6511244100"
                            )
                            
                            LicenseItemView(
                                title: "簡約マスター",
                                subtitle: "分数簡約アプリ",
                                linkTitle: "App Storeで見る",
                                linkURL: "https://apps.apple.com/jp/app/%E7%B0%A1%E7%B4%84%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%BC/id6602889397"
                            )
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct LicenseItemView: View {
    let title: String
    let subtitle: String
    let linkTitle: String
    let linkURL: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.potta(size: 15))
            Text(subtitle)
                .font(.potta(size: 15))
                .foregroundColor(.secondary)
            Link(linkTitle, destination: URL(string: linkURL)!)
                .font(.potta(size: 15))
                .foregroundColor(.r_Purple)
                .padding(.top, 4)
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    InfoView()
}
