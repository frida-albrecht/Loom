module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.225000e+01> : tensor<64x128xf32>}> : () -> tensor<64x128xf32>
    %1 = "tosa.const"() <{values = dense<8.321000e+01> : tensor<64x128xf32>}> : () -> tensor<64x128xf32>
    %2 = "tosa.const"() <{values = dense<1.733400e+02> : tensor<64x64xf32>}> : () -> tensor<64x64xf32>
    %3 = linalg.matmul_transpose_b ins(%0, %1 : tensor<64x128xf32>, tensor<64x128xf32>) outs(%2 : tensor<64x64xf32>) -> tensor<64x64xf32>
    %cast = tensor.cast %3 : tensor<64x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

