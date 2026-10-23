module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.127000e+01> : tensor<256x5xf32>}> : () -> tensor<256x5xf32>
    %1 = tensor.empty() : tensor<8x5x32xf32>
    %pack = linalg.pack %0 inner_dims_pos = [0] inner_tiles = [32] into %1 : tensor<256x5xf32> -> tensor<8x5x32xf32>
    %cast = tensor.cast %pack : tensor<8x5x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

