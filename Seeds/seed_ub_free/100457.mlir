module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.028000e+01> : tensor<16x32x64xf32>}> : () -> tensor<16x32x64xf32>
    %1 = "tosa.const"() <{values = dense<-2.665000e+01> : tensor<16x64xf32>}> : () -> tensor<16x64xf32>
    %reduced = linalg.reduce { arith.addf {fastmath = #arith.fastmath<fast>} } ins(%0 : tensor<16x32x64xf32>) outs(%1 : tensor<16x64xf32>) dimensions = [1] 
    %cast = tensor.cast %reduced : tensor<16x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

