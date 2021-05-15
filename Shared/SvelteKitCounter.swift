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
      Header().coverBackground().zIndex(1)
      CounterContent()
      Footer().coverBackground()
    }
  }
}

private struct CounterContent: View {
  var body: some View {
    VStack {
      Separator()
      Counter()
      Separator()
    }
    .padding(.leading)
    .padding(.trailing)
  }
}

private struct Separator: View {
  var body: some View {
    Rectangle()
      .fill(Color.gray)
      .opacity(0.5)
      .frame(height: 1)
  }
}

private struct CoverBackground: View {
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

extension View {
  func coverBackground() -> some View {
    ZStack {
      CoverBackground {
        self
      }
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
