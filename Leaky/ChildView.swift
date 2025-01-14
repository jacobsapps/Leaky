//
//  ChildView.swift
//  Leaky
//
//  Created by Jacob Bartlett on 14/01/2025.
//

import SwiftUI

struct CountingView: View {
    
    @State private var viewModel = CountingViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "clock")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Count: \(viewModel.count)")
                .foregroundStyle(.tint)
                .font(.title)
        }
        .padding()
        .onAppear {
            viewModel.startCounting()
        }
    }
}

#Preview {
    CountingView()
}

@Observable
final class CountingViewModel: BaseViewModel {
    
    var count = 0
    
    @ObservationIgnored
    private var timer: Timer?
    
    func startCounting() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.count += 1
        }
    }
}
