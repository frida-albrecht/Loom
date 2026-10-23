module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.754100e+02> : tensor<9x3x3x3xf32>}> : () -> tensor<9x3x3x3xf32>
    %1 = tosa.exp %0 : (tensor<9x3x3x3xf32>) -> tensor<9x3x3x3xf32>
    %2 = tosa.clamp %1 {max_val = 1.150000e+02 : f32, min_val = -2.700000e+01 : f32} : (tensor<9x3x3x3xf32>) -> tensor<9x3x3x3xf32>
    %3 = tosa.identity %2 : (tensor<9x3x3x3xf32>) -> tensor<9x3x3x3xf32>
    %cast = tensor.cast %3 : tensor<9x3x3x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

