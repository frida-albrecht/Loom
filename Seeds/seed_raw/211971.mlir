module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.024600e+02> : tensor<7x10x8x8xf32>}> : () -> tensor<7x10x8x8xf32>
    %1 = tosa.rsqrt %0 : (tensor<7x10x8x8xf32>) -> tensor<7x10x8x8xf32>
    %cast = tensor.cast %1 : tensor<7x10x8x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

