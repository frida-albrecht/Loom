module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<3x2x3x6xi32>}> : () -> tensor<3x2x3x6xi32>
    %1 = "tosa.const"() <{values = dense<-46> : tensor<3x1x1x1xi32>}> : () -> tensor<3x1x1x1xi32>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<3x2x3x6xi32>, tensor<3x1x1x1xi32>) -> tensor<3x2x3x6xi32>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = false} : (tensor<3x2x3x6xi32>, tensor<3x2x3x6xi32>) -> tensor<3x2x3x6xi32>
    %cast = tensor.cast %3 : tensor<3x2x3x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

