module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.855000e+01> : tensor<5x8x5xf32>}> : () -> tensor<5x8x5xf32>
    %1 = "tosa.const"() <{values = dense<64> : tensor<1x2x5x8xi32>}> : () -> tensor<1x2x5x8xi32>
    %2 = "tosa.const"() <{values = dense<91> : tensor<1x1x5x8xi32>}> : () -> tensor<1x1x5x8xi32>
    %3 = tosa.tanh %0 : (tensor<5x8x5xf32>) -> tensor<5x8x5xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<1x2x5x8xi32>, tensor<1x1x5x8xi32>) -> tensor<1x2x5x8xi32>
    %cast = tensor.cast %3 : tensor<5x8x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<1x2x5x8xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

