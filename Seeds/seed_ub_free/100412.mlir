module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.525000e+01> : tensor<32x64x16xf32>}> : () -> tensor<32x64x16xf32>
    %1 = tensor.empty() : tensor<32x1x16x64xf32>
    %pack = linalg.pack %0 inner_dims_pos = [1] inner_tiles = [64] into %1 : tensor<32x64x16xf32> -> tensor<32x1x16x64xf32>
    %cast = tensor.cast %pack : tensor<32x1x16x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

