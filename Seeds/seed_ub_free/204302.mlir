module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<5x6x1xi1>}> : () -> tensor<5x6x1xi1>
    %1 = "tosa.const"() <{values = dense<true> : tensor<6x2x7xi1>}> : () -> tensor<6x2x7xi1>
    %2 = "tosa.const"() <{values = dense<true> : tensor<1x2x1xi1>}> : () -> tensor<1x2x1xi1>
    %3 = tosa.argmax %0 {axis = 1 : i32} : (tensor<5x6x1xi1>) -> tensor<5x1xi32>
    %4 = tosa.logical_and %1, %2 : (tensor<6x2x7xi1>, tensor<1x2x1xi1>) -> tensor<6x2x7xi1>
    %5 = tosa.argmax %4 {axis = 2 : i32} : (tensor<6x2x7xi1>) -> tensor<6x2xi32>
    %cast = tensor.cast %3 : tensor<5x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<6x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

