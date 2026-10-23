module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.533000e+01> : tensor<2x4x7xf32>}> : () -> tensor<2x4x7xf32>
    %1 = "tosa.const"() <{values = dense<-1.943000e+02> : tensor<2x7x3xf32>}> : () -> tensor<2x7x3xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<2x4x7xf32>, tensor<2x7x3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2x4x3xf32>
    %5 = tosa.abs %4 : (tensor<2x4x3xf32>) -> tensor<2x4x3xf32>
    %6 = tosa.maximum %5, %4 : (tensor<2x4x3xf32>, tensor<2x4x3xf32>) -> tensor<2x4x3xf32>
    %cast = tensor.cast %6 : tensor<2x4x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

