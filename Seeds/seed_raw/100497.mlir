module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.856300e+02> : tensor<5x8x32xf32>}> : () -> tensor<5x8x32xf32>
    %1 = tensor.empty() : tensor<5x256xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 1] inner_dims_pos = [1] inner_tiles = [32] into %1 : tensor<5x8x32xf32> -> tensor<5x256xf32>
    %cast = tensor.cast %unpack : tensor<5x256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

