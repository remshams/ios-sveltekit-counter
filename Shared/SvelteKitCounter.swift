//
//  SvelteCounter.swift
//  swiftui-playground
//
//  Created by Mathias Remshardt on 09.05.21.
//

import SwiftUI

struct SvelteKitCounter: View {
  
  @State var nextCount = 0
  @State var count = 0
  @State var offset = 0
  
  var body: some View {
    HStack {
      Button(action: {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
          nextCount -= 1
          offset -= 120
        }
      }) {
        Image(systemName: "minus").font(.system(size: 40))
      }
      VStack(spacing: 0) {
        Rectangle()
          .fill(Color.white)
          .frame(width: 120)
          .ignoresSafeArea()
          .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        ZStack {
          ForEach(1..<12) { index in
            Text("\(count + index)").font(.system(size: 120)).offset(y: CGFloat(-120 * index))
          }
          
          Text("\(count)").font(.system(size: 120))
          ForEach(1..<12) { index in
            Text("\(count - index)").font(.system(size: 120)).offset(y: CGFloat(120 * index))
          }
        }.offset(y: CGFloat(offset))
        Rectangle()
          .fill(Color.white)
          .frame(width: 120)
          .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
          .ignoresSafeArea()
      }
      
      Button(action: {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
          nextCount += 1
          offset += 120
        }
        
      }) {
        Image(systemName: "plus").font(.system(size: 40))
      }
    }.onAnimationCompleted(for: CGFloat(offset)) {
      count = nextCount
      offset = 0
    }
  }
}

struct AnimationCompletionModifier<Data>: AnimatableModifier where Data: VectorArithmetic {
  var animatableData: Data {
    didSet {
      print(animatableData)
    }
  }
  
  func body(content: Content) -> some View {
    content
  }
  
  
}

struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
  
  /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
  var animatableData: Value {
    didSet {
      notifyCompletionIfFinished()
    }
  }
  
  /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
  private var targetValue: Value
  
  /// The completion callback which is called once the animation completes.
  private var completion: () -> Void
  
  init(observedValue: Value, completion: @escaping () -> Void) {
    self.completion = completion
    self.animatableData = observedValue
    targetValue = observedValue
  }
  
  /// Verifies whether the current animation is finished and calls the completion callback if true.
  private func notifyCompletionIfFinished() {
    guard animatableData == targetValue else { return }
    
    /// Dispatching is needed to take the next runloop for the completion callback.
    /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
    DispatchQueue.main.async {
      self.completion()
    }
  }
  
  func body(content: Content) -> some View {
    /// We're not really modifying the view so we can directly return the original input value.
    return content
  }
}

extension View {
  func onAnimationCompletion<Data>(data: Data) -> ModifiedContent<Self, AnimationCompletionModifier<Data>> {
    modifier(AnimationCompletionModifier(animatableData: data))
  }
  
  func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
    return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
  }
}

#if DEBUG
struct SvelteKitCounter_Previews: PreviewProvider {
  static var previews: some View {
    SvelteKitCounter()
  }
}
#endif
