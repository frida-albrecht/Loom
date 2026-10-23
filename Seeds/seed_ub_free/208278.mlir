module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<3x2x3x6xi32>}> : () -> tensor<3x2x3x6xi32>
    %1 = "tosa.const"() <{values = dense<-46> : tensor<3x1x1x1xi32>}> : () -> tensor<3x1x1x1xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<3x1x1x1xi32>}> : () -> tensor<3x1x1x1xi32>
    %c1 = "tosa.const"() <{values = dense<31> : tensor<3x1x1x1xi32>}> : () -> tensor<3x1x1x1xi32>
    %a1 = tosa.maximum %1, %c0 : (tensor<3x1x1x1xi32>, tensor<3x1x1x1xi32>) -> tensor<3x1x1x1xi32>
    %a2 = tosa.minimum %a1, %c1 : (tensor<3x1x1x1xi32>, tensor<3x1x1x1xi32>) -> tensor<3x1x1x1xi32>
    %2 = tosa.arithmetic_right_shift %0, %a2 {round = false} : (tensor<3x2x3x6xi32>, tensor<3x1x1x1xi32>) -> tensor<3x2x3x6xi32>
    %c2 = "tosa.const"() <{values = dense<0> : tensor<3x2x3x6xi32>}> : () -> tensor<3x2x3x6xi32>
    %c3 = "tosa.const"() <{values = dense<31> : tensor<3x2x3x6xi32>}> : () -> tensor<3x2x3x6xi32>
    %b1 = tosa.maximum %2, %c2 : (tensor<3x2x3x6xi32>, tensor<3x2x3x6xi32>) -> tensor<3x2x3x6xi32>
    %b2 = tosa.minimum %b1, %c3 : (tensor<3x2x3x6xi32>, tensor<3x2x3x6xi32>) -> tensor<3x2x3x6xi32>
    %3 = tosa.arithmetic_right_shift %2, %b2 {round = false} : (tensor<3x2x3x6xi32>, tensor<3x2x3x6xi32>) -> tensor<3x2x3x6xi32>
    %cast = tensor.cast %3 : tensor<3x2x3x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}