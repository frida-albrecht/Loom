module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.107000e+01> : tensor<2x9x1x3xf32>}> : () -> tensor<2x9x1x3xf32>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<2x9x1x3xf32>) -> tensor<2x1x3xi32>
    %2 = tosa.identity %1 : (tensor<2x1x3xi32>) -> tensor<2x1x3xi32>
    %3 = tosa.bitwise_and %2, %1 : (tensor<2x1x3xi32>, tensor<2x1x3xi32>) -> tensor<2x1x3xi32>
    %cast = tensor.cast %3 : tensor<2x1x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

