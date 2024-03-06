import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var biometricType = "unknown"
    @State private var unlocked = false
    @State private var text = "LOCKED"
    
    init() {
        getBiometricInfo() // Automatically run getBiometricInfo() when the app starts
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(biometricType)
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            Text(text)
            
            Button("Uỷ quyền Face ID") {
                authenticate()
            }
        }
        .padding()
    }
    
    func authenticate() {
        let authContext = LAContext()
        var error: NSError?
        
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "This is for security reasons") { success,
                authenticationError in
                
                if success {
                    text = "Uỷ quyền thành công!"
                } else {
                    text = "Uỷ quyền không thành công!"
                }
            }
        } else {
            
            text = "This iPhone does not seems to have biometric!"
        }
    }
    
    func getBiometricInfo() {
        let authContext = LAContext()
        
        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
            switch(authContext.biometryType) {
                case .none:
                    biometricType = "none"
                case .touchID:
                    biometricType = "touchID"
                case .faceID:
                    biometricType = "faceID"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
