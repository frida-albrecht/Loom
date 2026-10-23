module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.036000e+02> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %1 = tensor.empty() : tensor<16x16x8x8xf32>
    %pack = linalg.pack %0 inner_dims_pos = [0, 1] inner_tiles = [8, 8] into %1 : tensor<128x128xf32> -> tensor<16x16x8x8xf32>
    %2 = tensor.empty() : tensor<128x128xf32>
    %unpack = linalg.unpack %pack inner_dims_pos = [0, 1] inner_tiles = [8, 8] into %2 : tensor<16x16x8x8xf32> -> tensor<128x128xf32>
    %cast = tensor.cast %unpack : tensor<128x128xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

