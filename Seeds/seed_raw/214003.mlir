module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-182> : tensor<9x1x3xi64>}> : () -> tensor<9x1x3xi64>
    %1 = tosa.abs %0 : (tensor<9x1x3xi64>) -> tensor<9x1x3xi64>
    %2 = tosa.minimum %1, %1 : (tensor<9x1x3xi64>, tensor<9x1x3xi64>) -> tensor<9x1x3xi64>
    %3 = tosa.bitwise_and %2, %1 : (tensor<9x1x3xi64>, tensor<9x1x3xi64>) -> tensor<9x1x3xi64>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<9x1x3xi64>) -> tensor<1x3xi32>
    %5 = tosa.abs %4 : (tensor<1x3xi32>) -> tensor<1x3xi32>
    %6 = tosa.bitwise_and %5, %4 : (tensor<1x3xi32>, tensor<1x3xi32>) -> tensor<1x3xi32>
    %cast = tensor.cast %6 : tensor<1x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

