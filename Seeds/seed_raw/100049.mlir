module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.629300e+02> : tensor<8x32xf32>}> : () -> tensor<8x32xf32>
    %1 = "tosa.const"() <{values = dense<-1.231500e+02> : tensor<8x16x32xf32>}> : () -> tensor<8x16x32xf32>
    %broadcasted = linalg.broadcast ins(%0 : tensor<8x32xf32>) outs(%1 : tensor<8x16x32xf32>) dimensions = [1] 
    %cast = tensor.cast %broadcasted : tensor<8x16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

