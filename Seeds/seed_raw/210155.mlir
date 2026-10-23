module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.597000e+01> : tensor<7x6xf32>}> : () -> tensor<7x6xf32>
    %1 = tosa.tanh %0 : (tensor<7x6xf32>) -> tensor<7x6xf32>
    %cast = tensor.cast %1 : tensor<7x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

