module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.198000e+01> : tensor<1x1x32x8xf32>}> : () -> tensor<1x1x32x8xf32>
    %1 = "tosa.const"() <{values = dense<-2.990000e+01> : tensor<1x1x1x1x8x32xf32>}> : () -> tensor<1x1x1x1x8x32xf32>
    %pack = linalg.pack %0 outer_dims_perm = [0, 2, 3, 1] inner_dims_pos = [3, 2] inner_tiles = [8, 32] into %1 : tensor<1x1x32x8xf32> -> tensor<1x1x1x1x8x32xf32>
    %cast = tensor.cast %pack : tensor<1x1x1x1x8x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

