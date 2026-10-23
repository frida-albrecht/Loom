module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.746000e+01> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %1 = "tosa.const"() <{values = dense<-1.116600e+02> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %broadcasted = linalg.broadcast ins(%0 : tensor<2x3xf32>) outs(%1 : tensor<2x3xf32>) dimensions = [] 
    %cast = tensor.cast %broadcasted : tensor<2x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

