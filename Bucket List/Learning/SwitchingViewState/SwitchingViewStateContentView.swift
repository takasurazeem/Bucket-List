//
//  SwitchingViewStateContentView.swift
//  Bucket List
//
//  Created by Takasur Azeem on 08/07/2022.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct SwitchingViewStateContentView: View {
    
    var loadingState = LoadingState.loading
    
    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
        }
    }
}

struct SwitchingViewStateContentView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingViewStateContentView()
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}
