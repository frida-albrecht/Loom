module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.286200e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<9xf32>) -> tensor<1xf32>
    %2 = tosa.clamp %1 {max_val = 1.640000e+02 : f32, min_val = -2.000000e+00 : f32} : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %2 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

