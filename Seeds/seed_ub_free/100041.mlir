module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.631800e+02> : tensor<128x64xf32>}> : () -> tensor<128x64xf32>
    %1 = "tosa.const"() <{values = dense<-1.909100e+02> : tensor<128x64xf32>}> : () -> tensor<128x64xf32>
    %2 = "tosa.const"() <{values = dense<-1.463900e+02> : tensor<64x64xf32>}> : () -> tensor<64x64xf32>
    %3 = linalg.matmul_transpose_a ins(%0, %1 : tensor<128x64xf32>, tensor<128x64xf32>) outs(%2 : tensor<64x64xf32>) -> tensor<64x64xf32>
    %cast = tensor.cast %3 : tensor<64x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

