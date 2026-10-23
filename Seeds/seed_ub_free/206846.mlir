module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.874000e+01> : tensor<2x6xf32>}> : () -> tensor<2x6xf32>
    %1 = tosa.reciprocal %0 : (tensor<2x6xf32>) -> tensor<2x6xf32>
    %2 = tosa.clamp %1 {max_val = 5.800000e+01 : f32, min_val = -5.900000e+01 : f32} : (tensor<2x6xf32>) -> tensor<2x6xf32>
    %cast = tensor.cast %2 : tensor<2x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

