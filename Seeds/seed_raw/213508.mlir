module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<75> : tensor<3x1xi32>}> : () -> tensor<3x1xi32>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<3x1xi32>) -> tensor<1x1xi32>
    %2 = tosa.clamp %1 {max_val = -6 : i32, min_val = -49 : i32} : (tensor<1x1xi32>) -> tensor<1x1xi32>
    %cast = tensor.cast %2 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

