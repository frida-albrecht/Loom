module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<131> : tensor<3x3x8x7xi32>}> : () -> tensor<3x3x8x7xi32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1x3x1x7xi32>}> : () -> tensor<1x3x1x7xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<3x3x8x7xi32>, tensor<1x3x1x7xi32>) -> tensor<3x3x8x7xi32>
    %3 = tosa.bitwise_or %2, %2 : (tensor<3x3x8x7xi32>, tensor<3x3x8x7xi32>) -> tensor<3x3x8x7xi32>
    %4 = tosa.bitwise_or %3, %2 : (tensor<3x3x8x7xi32>, tensor<3x3x8x7xi32>) -> tensor<3x3x8x7xi32>
    %cast = tensor.cast %4 : tensor<3x3x8x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

