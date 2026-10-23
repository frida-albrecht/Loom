module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.097000e+01> : tensor<4x8xf32>}> : () -> tensor<4x8xf32>
    %1 = "tosa.const"() <{values = dense<-1.042100e+02> : tensor<4x8xf32>}> : () -> tensor<4x8xf32>
    %2 = linalg.copy ins(%0 : tensor<4x8xf32>) outs(%1 : tensor<4x8xf32>) -> tensor<4x8xf32>
    %cast = tensor.cast %2 : tensor<4x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

