module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.238800e+02> : tensor<20x1x12xf32>}> : () -> tensor<20x1x12xf32>
    %1 = "tosa.const"() <{values = dense<-7.943000e+01> : tensor<10x1x3x4x2xf32>}> : () -> tensor<10x1x3x4x2xf32>
    %pack = linalg.pack %0 inner_dims_pos = [2, 0] inner_tiles = [4, 2] into %1 : tensor<20x1x12xf32> -> tensor<10x1x3x4x2xf32>
    %cast = tensor.cast %pack : tensor<10x1x3x4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

