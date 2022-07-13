//
//  BioMetricLearning.swift
//  Bucket List
//
//  Created by Takasur Azeem on 13/07/2022.
//

import SwiftUI
import LocalAuthentication

struct BioMetricLearning: View {
    
    @State private var isUnlocked = false

    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct BioMetricLearning_Previews: PreviewProvider {
    static var previews: some View {
        BioMetricLearning()
    }
}
