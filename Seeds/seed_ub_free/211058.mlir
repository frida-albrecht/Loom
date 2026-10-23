module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.880000e+00> : tensor<2x2xf32>}> : () -> tensor<2x2xf32>
    %1 = tosa.exp %0 : (tensor<2x2xf32>) -> tensor<2x2xf32>
    %cast = tensor.cast %1 : tensor<2x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

