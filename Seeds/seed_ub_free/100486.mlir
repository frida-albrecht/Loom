module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.133200e+02> : tensor<1x1x1x1x8x32xf32>}> : () -> tensor<1x1x1x1x8x32xf32>
    %1 = "tosa.const"() <{values = dense<-82.4499969> : tensor<1x1x32x8xf32>}> : () -> tensor<1x1x32x8xf32>
    %unpack = linalg.unpack %0 inner_dims_pos = [3, 2] inner_tiles = [8, 32] into %1 : tensor<1x1x1x1x8x32xf32> -> tensor<1x1x32x8xf32>
    %cast = tensor.cast %unpack : tensor<1x1x32x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

