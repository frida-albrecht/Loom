module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.872600e+02> : tensor<3x9x6xf32>}> : () -> tensor<3x9x6xf32>
    %1 = tosa.clamp %0 {max_val = 1.250000e+02 : f32, min_val = -3.300000e+01 : f32} : (tensor<3x9x6xf32>) -> tensor<3x9x6xf32>
    %cast = tensor.cast %1 : tensor<3x9x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

