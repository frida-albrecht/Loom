module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-55> : tensor<6x5xi64>}> : () -> tensor<6x5xi64>
    %1 = "tosa.const"() <{values = dense<-89> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %2 = tosa.add %0, %1 : (tensor<6x5xi64>, tensor<1x1xi64>) -> tensor<6x5xi64>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<6x5xi64>) -> tensor<5xi32>
    %4 = tosa.arithmetic_right_shift %3, %3 {round = true} : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %cast = tensor.cast %4 : tensor<5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

