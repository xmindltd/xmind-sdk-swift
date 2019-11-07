//
//  ContentView.swift
//  XMindSDK-Demo-macOS
//
//  Created by CY H on 2019/11/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("XMindSDK")
            .frame(maxWidth: .infinity, maxHeight: .infinity).onAppear(perform: XMindFileTest)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
