module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.820000e+01> : tensor<3x5x7xf32>}> : () -> tensor<3x5x7xf32>
    %1 = "tosa.const"() <{values = dense<-1.016800e+02> : tensor<1x1x1x5x7x3xf32>}> : () -> tensor<1x1x1x5x7x3xf32>
    %pack = linalg.pack %0 inner_dims_pos = [1, 2, 0] inner_tiles = [5, 7, 3] into %1 : tensor<3x5x7xf32> -> tensor<1x1x1x5x7x3xf32>
    %cast = tensor.cast %pack : tensor<1x1x1x5x7x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

