//
//  TutorialView.swift
//  Moonlit
//
//  Created by Doruk Aydogan on 28.03.2024.
//
import SwiftUI
import Foundation
struct TutorialView: View {
    var body: some View {
        // Arka planı ve metni özelleştirerek tutorial sayfanızın görünümünü ayarlayın
        VStack {
            Spacer()
            Text("Welcome to the Tutorial")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Text("This is where we can introduce users to how to use this app")
                .font(.body)
                .padding()
            Spacer()
            // Burada daha fazla tutorial içeriği veya öğeleri ekleyebilirsiniz.
        }
        .padding()
        .navigationTitle("How To Use") // Eğer bir NavigationView içinde kullanıyorsanız, başlık ekleyebilirsiniz.
        .navigationBarTitleDisplayMode(.inline)
    }
}
