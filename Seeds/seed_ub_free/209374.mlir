module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.295600e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.rsqrt %0 : (tensor<1xf32>) -> tensor<1xf32>
    %2 = tosa.sigmoid %1 : (tensor<1xf32>) -> tensor<1xf32>
    %3 = tosa.clamp %2 {max_val = 1.130000e+02 : f32, min_val = -5.800000e+01 : f32} : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %3 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

