module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.983000e+01> : tensor<16x32x64xf32>}> : () -> tensor<16x32x64xf32>
    %1 = "tosa.const"() <{values = dense<2.305000e+01> : tensor<16x32x64xf32>}> : () -> tensor<16x32x64xf32>
    %transposed = linalg.transpose ins(%0 : tensor<16x32x64xf32>) outs(%1 : tensor<16x32x64xf32>) permutation = [0, 1, 2] 
    %cast = tensor.cast %transposed : tensor<16x32x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

