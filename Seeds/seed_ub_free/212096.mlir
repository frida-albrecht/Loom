module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<197> : tensor<9x1x6x7xi32>}> : () -> tensor<9x1x6x7xi32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = tosa.negate %0, %1, %2 : (tensor<9x1x6x7xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<9x1x6x7xi32>
    %4 = tosa.bitwise_not %3 : (tensor<9x1x6x7xi32>) -> tensor<9x1x6x7xi32>
    %cast = tensor.cast %4 : tensor<9x1x6x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

