module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-58> : tensor<2x1x3xi32>}> : () -> tensor<2x1x3xi32>
    %1 = "tosa.const"() <{values = dense<156> : tensor<1x1x1xi32>}> : () -> tensor<1x1x1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<2x1x3xi32>, tensor<1x1x1xi32>) -> tensor<2x1x3xi32>
    %3 = tosa.argmax %2 {axis = 2 : i32} : (tensor<2x1x3xi32>) -> tensor<2x1xi32>
    %4 = tosa.bitwise_and %3, %3 : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
    %5 = tosa.reverse %4 {axis = 1 : i32} : (tensor<2x1xi32>) -> tensor<2x1xi32>
    %cast = tensor.cast %5 : tensor<2x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

