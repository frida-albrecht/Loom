module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.240700e+02> : tensor<1x3x2x4x2xf32>}> : () -> tensor<1x3x2x4x2xf32>
    %1 = "tosa.const"() <{values = dense<-6.034000e+01> : tensor<1x5x7xf32>}> : () -> tensor<1x5x7xf32>
    %unpack = linalg.unpack %0 inner_dims_pos = [2, 1] inner_tiles = [4, 2] into %1 : tensor<1x3x2x4x2xf32> -> tensor<1x5x7xf32>
    %cast = tensor.cast %unpack : tensor<1x5x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

