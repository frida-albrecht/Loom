module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.663300e+02> : tensor<10x1x3x4x2xf32>}> : () -> tensor<10x1x3x4x2xf32>
    %1 = "tosa.const"() <{values = dense<-5.790000e+01> : tensor<20x1x12xf32>}> : () -> tensor<20x1x12xf32>
    %unpack = linalg.unpack %0 inner_dims_pos = [2, 0] inner_tiles = [4, 2] into %1 : tensor<10x1x3x4x2xf32> -> tensor<20x1x12xf32>
    %cast = tensor.cast %unpack : tensor<20x1x12xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

