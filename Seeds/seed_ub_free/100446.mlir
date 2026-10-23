module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.237700e+02> : tensor<1x1x3x1x3xf32>}> : () -> tensor<1x1x3x1x3xf32>
    %1 = "tosa.const"() <{values = dense<-8.500000e-01> : tensor<1x3x3xf32>}> : () -> tensor<1x3x3xf32>
    %inserted_slice = tensor.insert_slice %1 into %0[0, 0, 0, 0, 0] [1, 1, 3, 1, 3] [1, 1, 1, 1, 1] : tensor<1x3x3xf32> into tensor<1x1x3x1x3xf32>
    %cast = tensor.cast %inserted_slice : tensor<1x1x3x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

