module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.402000e+01> : tensor<7x4xf32>}> : () -> tensor<7x4xf32>
    %1 = tosa.identity %0 : (tensor<7x4xf32>) -> tensor<7x4xf32>
    %2 = tosa.concat %1, %1 {axis = 1 : i32} : (tensor<7x4xf32>, tensor<7x4xf32>) -> tensor<7x8xf32>
    %3 = tosa.clamp %2 {max_val = 8.000000e+01 : f32, min_val = 3.800000e+01 : f32} : (tensor<7x8xf32>) -> tensor<7x8xf32>
    %4 = tosa.exp %3 : (tensor<7x8xf32>) -> tensor<7x8xf32>
    %5 = tosa.tanh %4 : (tensor<7x8xf32>) -> tensor<7x8xf32>
    %6 = tosa.minimum %5, %3 : (tensor<7x8xf32>, tensor<7x8xf32>) -> tensor<7x8xf32>
    %cast = tensor.cast %6 : tensor<7x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

