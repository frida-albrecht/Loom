module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.494200e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<1.086400e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pow %0, %1 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %2 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

