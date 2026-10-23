module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.970000e+00> : tensor<16x1x1x2xf32>}> : () -> tensor<16x1x1x2xf32>
    %1 = tensor.empty() : tensor<32x1xf32>
    %unpack = linalg.unpack %0 inner_dims_pos = [1, 0] inner_tiles = [1, 2] into %1 : tensor<16x1x1x2xf32> -> tensor<32x1xf32>
    %cast = tensor.cast %unpack : tensor<32x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

