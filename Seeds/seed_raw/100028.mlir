module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.157000e+01> : tensor<64x128x256xf32>}> : () -> tensor<64x128x256xf32>
    %1 = "tosa.const"() <{values = dense<8.083000e+01> : tensor<64x1x256xf32>}> : () -> tensor<64x1x256xf32>
    %2 = "tosa.const"() <{values = dense<-1.541800e+02> : tensor<64x128x1xf32>}> : () -> tensor<64x128x1xf32>
    %3 = linalg.batch_matmul_transpose_b ins(%0, %1 : tensor<64x128x256xf32>, tensor<64x1x256xf32>) outs(%2 : tensor<64x128x1xf32>) -> tensor<64x128x1xf32>
    %cast = tensor.cast %3 : tensor<64x128x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

