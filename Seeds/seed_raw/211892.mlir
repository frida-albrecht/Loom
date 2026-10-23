module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<198> : tensor<3x3x5x3xi32>}> : () -> tensor<3x3x5x3xi32>
    %1 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<3x3x5x3xi32>) -> tensor<3x1x5x3xi32>
    %2 = tosa.reduce_min %1 {axis = 3 : i32} : (tensor<3x1x5x3xi32>) -> tensor<3x1x5x1xi32>
    %cast = tensor.cast %2 : tensor<3x1x5x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

