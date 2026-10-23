module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.005000e+01> : tensor<7xf32>}> : () -> tensor<7xf32>
    %1 = tosa.reciprocal %0 : (tensor<7xf32>) -> tensor<7xf32>
    %2 = tosa.reciprocal %1 : (tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %2 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

