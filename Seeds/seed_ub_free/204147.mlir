module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<70> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = tosa.clamp %0 {max_val = 102 : i32, min_val = 5 : i32} : (tensor<8xi32>) -> tensor<8xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<8xi32>}> : () -> tensor<8xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<8xi32>}> : () -> tensor<8xi32>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %clamped_shift = tosa.minimum %clamped_lower, %c31 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %2 = tosa.logical_right_shift %1, %clamped_shift : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<8xi32>) -> tensor<8xi32>
    %cast = tensor.cast %3 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}