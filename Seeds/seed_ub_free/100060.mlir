module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.750000e+01> : tensor<32x64xf32>}> : () -> tensor<32x64xf32>
    %1 = tensor.empty() : tensor<32x4x4x4xf32>
    %expanded = tensor.expand_shape %0 [[0], [1, 2]] output_shape [32, 4, 16] : tensor<32x64xf32> into tensor<32x4x16xf32>
    %pack = linalg.pack %expanded inner_dims_pos = [2] inner_tiles = [4] into %1 : tensor<32x4x16xf32> -> tensor<32x4x4x4xf32>
    %cast = tensor.cast %pack : tensor<32x4x4x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

