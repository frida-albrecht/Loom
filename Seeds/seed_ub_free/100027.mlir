module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.979700e+02> : tensor<8x128x256xf32>}> : () -> tensor<8x128x256xf32>
    %1 = "tosa.const"() <{values = dense<4.681000e+01> : tensor<8x256x512xf32>}> : () -> tensor<8x256x512xf32>
    %2 = "tosa.const"() <{values = dense<1.193200e+02> : tensor<128x512xf32>}> : () -> tensor<128x512xf32>
    %3 = linalg.batch_reduce_matmul ins(%0, %1 : tensor<8x128x256xf32>, tensor<8x256x512xf32>) outs(%2 : tensor<128x512xf32>) -> tensor<128x512xf32>
    %cast = tensor.cast %3 : tensor<128x512xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

