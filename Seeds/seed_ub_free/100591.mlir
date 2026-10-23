module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.412000e+01> : tensor<8x32xf32>}> : () -> tensor<8x32xf32>
    %1 = tensor.empty() : tensor<255xf32>
    %unpack = linalg.unpack %0 inner_dims_pos = [0] inner_tiles = [32] into %1 : tensor<8x32xf32> -> tensor<255xf32>
    %cast = tensor.cast %unpack : tensor<255xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

