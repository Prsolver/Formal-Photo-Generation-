import SwiftUI
import PassKit

struct PaymentView: View {
    var body: some View {
        VStack {
            if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [.visa, .masterCard, .amex], capabilities: .capability3DS) {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    ApplePayButton(action: startApplePay)
                        .frame(width: 200, height: 44)
                }
            } else {
                Text("Apple Pay is not available.")
            }
        }
    }
    
    func startApplePay() {
        let paymentNetworks = [PKPaymentNetwork.visa, .masterCard, .amex]
        let paymentRequest = PKPaymentRequest()
        paymentRequest.currencyCode = "USD" // Para birimi
        paymentRequest.countryCode = "US"  // Ülke kodu
        paymentRequest.merchantIdentifier = "your.merchant.id" // Merchant ID'nizi girin
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.supportedNetworks = paymentNetworks
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: 10.00))
        ]
        
        if let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            paymentVC.delegate = UIApplication.shared.windows.first?.rootViewController as? PKPaymentAuthorizationViewControllerDelegate
            UIApplication.shared.windows.first?.rootViewController?.present(paymentVC, animated: true)
        }
    }
}


struct ApplePayButton: UIViewRepresentable {
    var action: () -> Void
    
    func makeUIView(context: Context) -> some UIView {
        let button = PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .whiteOutline)
        button.addTarget(context.coordinator, action: #selector(Coordinator.pay), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true // Genişlik ayarı
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true // Yükseklik ayarı
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    class Coordinator: NSObject {
        var action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        @objc func pay() {
            action()
        }
    }
}



