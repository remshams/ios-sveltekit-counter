//
//  SvelteCounter.swift
//  swiftui-playground
//
//  Created by Mathias Remshardt on 09.05.21.
//

import SwiftUI

struct SvelteKitCounter: View {
  var body: some View {
    VStack(spacing: 0) {
      Backdrop {
        Header()
      }.zIndex(1)
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
      SvelteKitCounter().previewLayout(.sizeThatFits)
      SvelteKitCounter().previewLayout(.fixed(width: 2532 / 3.0, height: 1170 / 3.0))
    }
  }
#endif
