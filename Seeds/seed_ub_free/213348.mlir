module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.373000e+02> : tensor<10x3x5xf32>}> : () -> tensor<10x3x5xf32>
    %1 = "tosa.const"() <{values = dense<1.077500e+02> : tensor<10x3x5xf32>}> : () -> tensor<10x3x5xf32>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<10x3x5xf32>}> : () -> tensor<10x3x5xf32>
    %clamped_base = tosa.maximum %0, %c0 : (tensor<10x3x5xf32>, tensor<10x3x5xf32>) -> tensor<10x3x5xf32>
    %2 = tosa.pow %clamped_base, %1 : (tensor<10x3x5xf32>, tensor<10x3x5xf32>) -> tensor<10x3x5xf32>
    %cast = tensor.cast %2 : tensor<10x3x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}