import SwiftUI
struct AuthWithPhoneSMS: View {
    @State private var phoneNumber = ""
    @State private var verificationCode = ""
    @State private var isVerificationCodeSent = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
                    if !isVerificationCodeSent {
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(.white)
                        // Telefon numarası için gönder butonu
                        Button(action: {
                            sendVerificationCode()
                        }) {
                            Text("Send Verification Code")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    } else {
                        TextField("Verification Code", text: $verificationCode)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(.white)
                        // Doğrulama kodu için doğrula butonu
                        Button(action: {
                            verifyCode()
                        }) {
                            Text("Verify")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
            }
            .navigationBarHidden(false)
            .edgesIgnoringSafeArea(.all)
        }
    }

    func sendVerificationCode() {
        // Supabase client kullanarak SMS gönderme işlemi
        isVerificationCodeSent = true
    }

    func verifyCode() {
        // Supabase client kullanarak kod doğrulama ve oturum açma işlemi
    }
}
