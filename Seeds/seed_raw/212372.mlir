module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-178> : tensor<9x6x2xi64>}> : () -> tensor<9x6x2xi64>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<9x6x2xi64>) -> tensor<6x2xi32>
    %2 = tosa.logical_left_shift %1, %1 : (tensor<6x2xi32>, tensor<6x2xi32>) -> tensor<6x2xi32>
    %cast = tensor.cast %2 : tensor<6x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

