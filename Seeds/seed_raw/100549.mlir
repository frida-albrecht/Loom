module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.076200e+02> : tensor<16x32x64xf32>}> : () -> tensor<16x32x64xf32>
    %1 = "tosa.const"() <{values = dense<1.930300e+02> : tensor<32x64x16xf32>}> : () -> tensor<32x64x16xf32>
    %transposed = linalg.transpose ins(%0 : tensor<16x32x64xf32>) outs(%1 : tensor<32x64x16xf32>) permutation = [1, 2, 0] 
    %cast = tensor.cast %transposed : tensor<32x64x16xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

