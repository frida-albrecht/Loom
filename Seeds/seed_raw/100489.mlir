module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.744100e+02> : tensor<1x16x8x32xf32>}> : () -> tensor<1x16x8x32xf32>
    %1 = "tosa.const"() <{values = dense<1.596400e+02> : tensor<1x32x16x8xf32>}> : () -> tensor<1x32x16x8xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 2, 3, 1] inner_dims_pos = [] inner_tiles = [] into %1 : tensor<1x16x8x32xf32> -> tensor<1x32x16x8xf32>
    %cast = tensor.cast %unpack : tensor<1x32x16x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

