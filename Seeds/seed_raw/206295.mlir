module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.371000e+01> : tensor<4x2x1x3xf32>}> : () -> tensor<4x2x1x3xf32>
    %1 = tosa.reverse %0 {axis = 2 : i32} : (tensor<4x2x1x3xf32>) -> tensor<4x2x1x3xf32>
    %2 = tosa.minimum %1, %1 : (tensor<4x2x1x3xf32>, tensor<4x2x1x3xf32>) -> tensor<4x2x1x3xf32>
    %3 = tosa.pow %2, %2 : (tensor<4x2x1x3xf32>, tensor<4x2x1x3xf32>) -> tensor<4x2x1x3xf32>
    %cast = tensor.cast %3 : tensor<4x2x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

