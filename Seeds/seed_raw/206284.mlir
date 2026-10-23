module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<27> : tensor<6x3x5x5xi64>}> : () -> tensor<6x3x5x5xi64>
    %1 = "tosa.const"() <{values = dense<76> : tensor<6x1x5x5xi64>}> : () -> tensor<6x1x5x5xi64>
    %2 = tosa.add %0, %1 : (tensor<6x3x5x5xi64>, tensor<6x1x5x5xi64>) -> tensor<6x3x5x5xi64>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<6x3x5x5xi64>) -> tensor<3x5x5xi32>
    %cast = tensor.cast %3 : tensor<3x5x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

