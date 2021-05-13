//
//  SvelteCounter.swift
//  swiftui-playground
//
//  Created by Mathias Remshardt on 09.05.21.
//

import SwiftUI

struct SvelteKitCounter: View {
  
  
  var body: some View {
    VStack {
      Backdrop().zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
      Counter()
      Backdrop()
    }
  }
}

struct Backdrop: View {
  let content: AnyView
  
  init<Content: View>(@ViewBuilder content: () -> Content) {
    self.content = AnyView(content())
  }
  
  init() {
    self.init {
      EmptyView()
    }
  }
  
  var body: some View {
    ZStack {
      Rectangle().fill(Color.white).ignoresSafeArea()
      content
    }
  }
}

#if DEBUG
struct SvelteKitCounter_Previews: PreviewProvider {
  static var previews: some View {
    SvelteKitCounter()
  }
}
#endif
