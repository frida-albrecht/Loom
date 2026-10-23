module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.569000e+01> : tensor<1x1x32x8xf32>}> : () -> tensor<1x1x32x8xf32>
    %1 = "tosa.const"() <{values = dense<5.466000e+01> : tensor<32x8xf32>}> : () -> tensor<32x8xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [1, 0] inner_dims_pos = [0, 1] inner_tiles = [32, 8] into %1 : tensor<1x1x32x8xf32> -> tensor<32x8xf32>
    %cast = tensor.cast %unpack : tensor<32x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

