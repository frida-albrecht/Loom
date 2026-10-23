module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<193> : tensor<6x2xi32>}> : () -> tensor<6x2xi32>
    %1 = "tosa.const"() <{values = dense<36> : tensor<6x1xi32>}> : () -> tensor<6x1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<6x2xi32>, tensor<6x1xi32>) -> tensor<6x2xi32>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = true} : (tensor<6x2xi32>, tensor<6x2xi32>) -> tensor<6x2xi32>
    %cast = tensor.cast %3 : tensor<6x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

