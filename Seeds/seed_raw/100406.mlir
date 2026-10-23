module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.755700e+02> : tensor<32x64xf32>}> : () -> tensor<32x64xf32>
    %1 = tensor.empty() : tensor<1x1x64x32xf32>
    %pack = linalg.pack %0 inner_dims_pos = [1, 0] inner_tiles = [64, 32] into %1 : tensor<32x64xf32> -> tensor<1x1x64x32xf32>
    %cast = tensor.cast %pack : tensor<1x1x64x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

