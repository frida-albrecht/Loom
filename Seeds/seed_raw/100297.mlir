module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.096200e+02> : tensor<64xf32>}> : () -> tensor<64xf32>
    %1 = "tosa.const"() <{values = dense<-1.090000e+02> : tensor<64xf32>}> : () -> tensor<64xf32>
    %2 = "tosa.const"() <{values = dense<-1.002000e+02> : tensor<64xf32>}> : () -> tensor<64xf32>
    %mapped = linalg.map { arith.addf {fastmath = #arith.fastmath<fast>} } ins(%0, %1 : tensor<64xf32>, tensor<64xf32>) outs(%2 : tensor<64xf32>)
    %cast = tensor.cast %mapped : tensor<64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

