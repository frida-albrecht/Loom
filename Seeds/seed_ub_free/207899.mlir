module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.530000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.tanh %0 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %1 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

