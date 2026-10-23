module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<188> : tensor<9x9x5x2xi32>}> : () -> tensor<9x9x5x2xi32>
    %1 = "tosa.const"() <{values = dense<135> : tensor<1x1x1x1xi32>}> : () -> tensor<1x1x1x1xi32>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<9x9x5x2xi32>, tensor<1x1x1x1xi32>) -> tensor<9x9x5x2xi32>
    %3 = tosa.add %2, %2 : (tensor<9x9x5x2xi32>, tensor<9x9x5x2xi32>) -> tensor<9x9x5x2xi32>
    %4 = tosa.equal %3, %2 : (tensor<9x9x5x2xi32>, tensor<9x9x5x2xi32>) -> tensor<9x9x5x2xi1>
    %5 = tosa.bitwise_or %4, %4 : (tensor<9x9x5x2xi1>, tensor<9x9x5x2xi1>) -> tensor<9x9x5x2xi1>
    %6 = tosa.argmax %5 {axis = 1 : i32} : (tensor<9x9x5x2xi1>) -> tensor<9x5x2xi32>
    %cast = tensor.cast %6 : tensor<9x5x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

