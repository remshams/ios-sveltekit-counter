//
//  AnimationCompletionObserver.swift
//  sveltekit-counter
//
//  Created by Mathias Remshardt on 11.05.21.
//

import Foundation
import SwiftUI

struct AnimationCompletionObserver<Value>: AnimatableModifier where Value: VectorArithmetic {
  
  var animatableData: Value {
    didSet {
      notifyCompletionIfFinished()
    }
  }
  
  private var targetValue: Value
  
  private var completion: () -> Void
  
  init(observedValue: Value, completion: @escaping () -> Void) {
    self.completion = completion
    self.animatableData = observedValue
    targetValue = observedValue
  }
  
  private func notifyCompletionIfFinished() {
    guard animatableData == targetValue else { return }
    
    DispatchQueue.main.async {
      self.completion()
    }
  }
  
  func body(content: Content) -> some View {
    content
  }
}

extension View {
  
  func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserver<Value>> {
    return modifier(AnimationCompletionObserver(observedValue: value, completion: completion))
  }
}
