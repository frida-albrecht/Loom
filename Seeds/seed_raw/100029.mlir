module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.243000e+01> : tensor<16x8xf32>}> : () -> tensor<16x8xf32>
    %1 = "tosa.const"() <{values = dense<2.006000e+01> : tensor<16x8xf32>}> : () -> tensor<16x8xf32>
    %2 = "tosa.const"() <{values = dense<-1.352700e+02> : tensor<16x8xf32>}> : () -> tensor<16x8xf32>
    %3 = linalg.elementwise kind=#linalg.elementwise_kind<div> ins(%0, %1 : tensor<16x8xf32>, tensor<16x8xf32>) outs(%2 : tensor<16x8xf32>) -> tensor<16x8xf32>
    %cast = tensor.cast %3 : tensor<16x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

