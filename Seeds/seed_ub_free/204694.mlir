module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<21> : tensor<7xi32>}> : () -> tensor<7xi32>
    %1 = "tosa.const"() <{values = dense<195> : tensor<7xi32>}> : () -> tensor<7xi32>
    %2 = tosa.bitwise_and %0, %1 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %4 = tosa.logical_left_shift %3, %3 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %cast = tensor.cast %4 : tensor<7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

