module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.265000e+01> : tensor<256x1xf32>}> : () -> tensor<256x1xf32>
    %1 = "tosa.const"() <{values = dense<-4.289000e+01> : tensor<256x512xf32>}> : () -> tensor<256x512xf32>
    %2 = "tosa.const"() <{values = dense<-7.391000e+01> : tensor<1x512xf32>}> : () -> tensor<1x512xf32>
    %3 = linalg.matmul_transpose_a ins(%0, %1 : tensor<256x1xf32>, tensor<256x512xf32>) outs(%2 : tensor<1x512xf32>) -> tensor<1x512xf32>
    %cast = tensor.cast %3 : tensor<1x512xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

