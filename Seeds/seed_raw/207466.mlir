module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.460800e+02> : tensor<9x2x3x4xf32>}> : () -> tensor<9x2x3x4xf32>
    %1 = "tosa.const"() <{values = dense<-2.691000e+01> : tensor<9x2x3x1xf32>}> : () -> tensor<9x2x3x1xf32>
    %2 = tosa.maximum %0, %1 : (tensor<9x2x3x4xf32>, tensor<9x2x3x1xf32>) -> tensor<9x2x3x4xf32>
    %3 = tosa.maximum %2, %2 : (tensor<9x2x3x4xf32>, tensor<9x2x3x4xf32>) -> tensor<9x2x3x4xf32>
    %4 = tosa.clamp %3 {max_val = 2.100000e+01 : f32, min_val = -1.000000e+01 : f32} : (tensor<9x2x3x4xf32>) -> tensor<9x2x3x4xf32>
    %cast = tensor.cast %4 : tensor<9x2x3x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

