module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.551000e+01> : tensor<8x32xf32>}> : () -> tensor<8x32xf32>
    %1 = tensor.empty() : tensor<256xf32>
    %unpack = linalg.unpack %0 inner_dims_pos = [0] inner_tiles = [32] into %1 : tensor<8x32xf32> -> tensor<256xf32>
    %cast = tensor.cast %unpack : tensor<256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

