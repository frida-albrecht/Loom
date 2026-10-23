module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.504300e+02> : tensor<1x32xf32>}> : () -> tensor<1x32xf32>
    %1 = tensor.empty() : tensor<1x16x1x2xf32>
    %pack = linalg.pack %0 inner_dims_pos = [0, 1] inner_tiles = [1, 2] into %1 : tensor<1x32xf32> -> tensor<1x16x1x2xf32>
    %cast = tensor.cast %pack : tensor<1x16x1x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

