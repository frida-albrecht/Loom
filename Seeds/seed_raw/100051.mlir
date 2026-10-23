module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.017000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<1.046600e+02> : tensor<2x4xf32>}> : () -> tensor<2x4xf32>
    %2 = "tosa.const"() <{values = dense<-3.382000e+01> : tensor<4x2xf32>}> : () -> tensor<4x2xf32>
    %broadcasted = linalg.broadcast ins(%0 : tensor<2xf32>) outs(%1 : tensor<2x4xf32>) dimensions = [1] 
    %transposed = linalg.transpose ins(%broadcasted : tensor<2x4xf32>) outs(%2 : tensor<4x2xf32>) permutation = [1, 0] 
    %cast = tensor.cast %transposed : tensor<4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

