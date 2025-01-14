//
//  ContentView.swift
//  Leaky
//
//  Created by Jacob Bartlett on 14/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ContentViewModel()
    @State private var showCounting = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("View Counting Screen") {
                showCounting = true
            }
        }
        .padding()
        .sheet(isPresented: $showCounting) {
            CountingView()
        }
    }
}

#Preview {
    ContentView()
}

@Observable
final class ContentViewModel: BaseViewModel {
    var showCounting = false
}

