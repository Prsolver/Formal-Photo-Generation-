import SwiftUI
import Supabase

struct AuthView: View {
    enum Option: CaseIterable {
        case emailAndPassword, magicLink, signInWithApple, phoneAuth

        var title: String {
            switch self {
            case .emailAndPassword: return "Auth with Email & Password"
            case .magicLink: return "Auth with Magic Link"
            case .signInWithApple: return "Sign in with Apple"
            case .phoneAuth: return "Auth with Phone SMS"
            }
        }
    }


    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    // Daireler ve MOONLIT metni için ZStack ekleniyor.
                    ZStack {
                        // Daire tasarımları, metnin arka planında olacak
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 150, height: 150)
                            .offset(x: -40, y: 0) // Pozisyon ayarlaması

                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 110, height: 110)
                            .offset(x: 35, y: -50) // Pozisyon ayarlaması

                        // MOONLIT metni, dairelerin önünde olacak
                        Text("MEMETIC")
                            .font(.largeTitle.italic())
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(y: 150) // Metni aşağı çekmek için pozisyon ayarlaması
                    }
                    .padding(.bottom, 125) // MOONLIT ve seçenekler arası boşluk

                    // Diğer navigation linkleriniz burada
                    ForEach(Option.allCases, id: \.self) { option in
                        NavigationLink(destination: option.destinationView) {
                            Text(option.title)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                                .cornerRadius(10)
                                .opacity(1)
                        }
                        .padding(.horizontal, 50)
                    }
                }
            }
        }
    }




}

extension AuthView.Option {
    @ViewBuilder
    var destinationView: some View {
        switch self {
       
        case .emailAndPassword:
            AuthWithEmailAndPassword()
        case .magicLink:
            AuthWithMagicLink()
        case .signInWithApple:
            SignInWithApple()
        case .phoneAuth:
            AuthWithPhoneSMS()
        }
    }
}
