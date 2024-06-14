import Auth
import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 150, height: 150)
                    .offset(x: -40, y: 0) // Pozisyon ayarlaması

                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 110, height: 110)
                    .offset(x: 35, y: -50) // Pozisyon ayarlaması
            }

            Text("MEMETIC")
                .font(.largeTitle.italic())
                .fontWeight(.bold)
                .foregroundColor(.white)
                 
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}







struct RootView: View {
    @Environment(AuthController.self) var auth
    @State private var showSplashScreen = true

    var body: some View {
        ZStack {
            if auth.session == nil {
                
               AuthView().opacity(showSplashScreen ? 0 : 1)
            } else {
                //PaymentView()
               ContentView(id: auth.currentUserID).opacity(showSplashScreen ? 0 : 1)
            }

            if showSplashScreen {
                SplashScreen()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1)) {
                    showSplashScreen = false
                }
            }
        }
       
        .transition(.scale)
    }
}
