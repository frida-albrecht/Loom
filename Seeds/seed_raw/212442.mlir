module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.905400e+02> : tensor<5x9x3xf32>}> : () -> tensor<5x9x3xf32>
    %1 = tosa.rsqrt %0 : (tensor<5x9x3xf32>) -> tensor<5x9x3xf32>
    %2 = tosa.clamp %1 {max_val = 4.700000e+01 : f32, min_val = -2.000000e+00 : f32} : (tensor<5x9x3xf32>) -> tensor<5x9x3xf32>
    %cast = tensor.cast %2 : tensor<5x9x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

