module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.092200e+02> : tensor<8x16x32xf32>}> : () -> tensor<8x16x32xf32>
    %1 = "tosa.const"() <{values = dense<1.800000e-01> : tensor<8x16x32xf32>}> : () -> tensor<8x16x32xf32>
    %2 = linalg.elementwise kind=#linalg.elementwise_kind<exp> ins(%0 : tensor<8x16x32xf32>) outs(%1 : tensor<8x16x32xf32>) -> tensor<8x16x32xf32>
    %cast = tensor.cast %2 : tensor<8x16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

