module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.332000e+01> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = tosa.reciprocal %0 : (tensor<6xf32>) -> tensor<6xf32>
    %2 = tosa.floor %1 : (tensor<6xf32>) -> tensor<6xf32>
    %3 = tosa.exp %2 : (tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %3 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

