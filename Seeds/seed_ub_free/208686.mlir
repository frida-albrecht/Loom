module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.221000e+01> : tensor<5x7x4xf32>}> : () -> tensor<5x7x4xf32>
    %1 = "tosa.const"() <{values = dense<-1.762600e+02> : tensor<5x4x6xf32>}> : () -> tensor<5x4x6xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<5x7x4xf32>, tensor<5x4x6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<5x7x6xf32>
    %5 = tosa.clamp %4 {max_val = 7.500000e+01 : f32, min_val = 1.700000e+01 : f32} : (tensor<5x7x6xf32>) -> tensor<5x7x6xf32>
    %cast = tensor.cast %5 : tensor<5x7x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

