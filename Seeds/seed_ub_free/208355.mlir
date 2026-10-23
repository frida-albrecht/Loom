module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<75> : tensor<1x4x3xi32>}> : () -> tensor<1x4x3xi32>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<1x4x3xi32>) -> tensor<1x4x3xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x4x3xi32>}> : () -> tensor<1x4x3xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<1x4x3xi32>}> : () -> tensor<1x4x3xi32>
    %a1 = tosa.maximum %1, %c0 : (tensor<1x4x3xi32>, tensor<1x4x3xi32>) -> tensor<1x4x3xi32>
    %a2 = tosa.minimum %a1, %c31 : (tensor<1x4x3xi32>, tensor<1x4x3xi32>) -> tensor<1x4x3xi32>
    %2 = tosa.logical_left_shift %1, %a2 : (tensor<1x4x3xi32>, tensor<1x4x3xi32>) -> tensor<1x4x3xi32>
    %cast = tensor.cast %2 : tensor<1x4x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}