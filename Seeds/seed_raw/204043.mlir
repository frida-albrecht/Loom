module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.052000e+01> : tensor<2x3x8xf32>}> : () -> tensor<2x3x8xf32>
    %1 = "tosa.const"() <{values = dense<76.5299987> : tensor<2x3x1xf32>}> : () -> tensor<2x3x1xf32>
    %2 = tosa.maximum %0, %1 : (tensor<2x3x8xf32>, tensor<2x3x1xf32>) -> tensor<2x3x8xf32>
    %3 = tosa.concat %2, %2 {axis = 1 : i32} : (tensor<2x3x8xf32>, tensor<2x3x8xf32>) -> tensor<2x6x8xf32>
    %cast = tensor.cast %3 : tensor<2x6x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

