module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.060000e+00> : tensor<2x9xf32>}> : () -> tensor<2x9xf32>
    %1 = tosa.rsqrt %0 : (tensor<2x9xf32>) -> tensor<2x9xf32>
    %2 = tosa.rsqrt %1 : (tensor<2x9xf32>) -> tensor<2x9xf32>
    %cast = tensor.cast %2 : tensor<2x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

