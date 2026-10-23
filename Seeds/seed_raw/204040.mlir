module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-89> : tensor<3x5x2x2xi64>}> : () -> tensor<3x5x2x2xi64>
    %1 = tosa.argmax %0 {axis = 3 : i32} : (tensor<3x5x2x2xi64>) -> tensor<3x5x2xi32>
    %2 = tosa.reverse %1 {axis = 2 : i32} : (tensor<3x5x2xi32>) -> tensor<3x5x2xi32>
    %3 = tosa.maximum %2, %2 : (tensor<3x5x2xi32>, tensor<3x5x2xi32>) -> tensor<3x5x2xi32>
    %4 = tosa.abs %3 : (tensor<3x5x2xi32>) -> tensor<3x5x2xi32>
    %5 = tosa.minimum %4, %4 : (tensor<3x5x2xi32>, tensor<3x5x2xi32>) -> tensor<3x5x2xi32>
    %cast = tensor.cast %5 : tensor<3x5x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

