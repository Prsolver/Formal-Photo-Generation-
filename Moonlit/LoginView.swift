import SwiftUI
import Supabase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    private let supabaseClient = SupabaseClient(supabaseURL: URL(string: "https://siwevkowrdrxrkklqkvm.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNpd2V2a293cmRyeHJra2xxa3ZtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEwNjc5NTIsImV4cCI6MjAyNjY0Mzk1Mn0.vg4GRcMJL_Icv_-Oo5OenNWaIGvJBvTtZwLzD1vtZsc")

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Login") {
                Task {
                    await login()
                }
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }

    func login() async {
        do {
            let session = try await supabaseClient.auth.signIn(email: email, password: password)
            print("Login successful: \(session.user.email)")
            // Oturum açma başarılı, kullanıcıyı yönlendirin
            // UI ile ilgili güncellemeleri ana thread'de yapın
        } catch {
            print("Login failed: \(error.localizedDescription)")
            // Hata mesajını ana thread üzerinde güncelleyin
            DispatchQueue.main.async {
                errorMessage = error.localizedDescription
            }
        }

    }
}
