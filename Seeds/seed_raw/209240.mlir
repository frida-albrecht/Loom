module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<32> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<-84> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %3 = tosa.maximum %2, %2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %4 = tosa.reverse %3 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %5 = tosa.maximum %4, %4 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %6 = tosa.reverse %5 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %7 = tosa.abs %6 : (tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %7 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

