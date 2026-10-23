module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.572000e+01> : tensor<4x1x7x8xf32>}> : () -> tensor<4x1x7x8xf32>
    %1 = tosa.log %0 : (tensor<4x1x7x8xf32>) -> tensor<4x1x7x8xf32>
    %2 = tosa.reverse %1 {axis = 3 : i32} : (tensor<4x1x7x8xf32>) -> tensor<4x1x7x8xf32>
    %3 = tosa.clamp %2 {max_val = 2.200000e+01 : f32, min_val = 2.100000e+01 : f32} : (tensor<4x1x7x8xf32>) -> tensor<4x1x7x8xf32>
    %4 = tosa.reciprocal %3 : (tensor<4x1x7x8xf32>) -> tensor<4x1x7x8xf32>
    %5 = tosa.floor %4 : (tensor<4x1x7x8xf32>) -> tensor<4x1x7x8xf32>
    %cast = tensor.cast %5 : tensor<4x1x7x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

