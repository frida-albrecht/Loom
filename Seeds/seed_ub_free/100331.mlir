module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.077000e+01> : tensor<10x32x8x1xf32>}> : () -> tensor<10x32x8x1xf32>
    %1 = "tosa.const"() <{values = dense<-8.983000e+01> : tensor<80x32x4x1xf32>}> : () -> tensor<80x32x4x1xf32>
    %2 = "tosa.const"() <{values = dense<1.917200e+02> : tensor<10x80x8x4xf32>}> : () -> tensor<10x80x8x4xf32>
    %3 = linalg.mmt4d ins(%0, %1 : tensor<10x32x8x1xf32>, tensor<80x32x4x1xf32>) outs(%2 : tensor<10x80x8x4xf32>) -> tensor<10x80x8x4xf32>
    %cast = tensor.cast %3 : tensor<10x80x8x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

