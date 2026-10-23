module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.712000e+01> : tensor<10xf32>}> : () -> tensor<10xf32>
    %1 = "tosa.const"() <{values = dense<7.249000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.maximum %0, %1 : (tensor<10xf32>, tensor<1xf32>) -> tensor<10xf32>
    %cast = tensor.cast %2 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

