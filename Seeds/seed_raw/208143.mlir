module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.340000e+00> : tensor<2x9x8xf32>}> : () -> tensor<2x9x8xf32>
    %1 = "tosa.const"() <{values = dense<7.424000e+01> : tensor<2x9x1xf32>}> : () -> tensor<2x9x1xf32>
    %2 = tosa.sub %0, %1 : (tensor<2x9x8xf32>, tensor<2x9x1xf32>) -> tensor<2x9x8xf32>
    %cast = tensor.cast %2 : tensor<2x9x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

