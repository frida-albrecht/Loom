module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.751000e+01> : tensor<2x2x2x8xf32>}> : () -> tensor<2x2x2x8xf32>
    %1 = tosa.reciprocal %0 : (tensor<2x2x2x8xf32>) -> tensor<2x2x2x8xf32>
    %cast = tensor.cast %1 : tensor<2x2x2x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

