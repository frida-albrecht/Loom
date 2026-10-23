module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.249600e+02> : tensor<1x1x4xf32>}> : () -> tensor<1x1x4xf32>
    %1 = "tosa.const"() <{values = dense<1.203800e+02> : tensor<1x1x1x4x1xf32>}> : () -> tensor<1x1x1x4x1xf32>
    %pack = linalg.pack %0 outer_dims_perm = [1, 2, 0] inner_dims_pos = [2, 1] inner_tiles = [4, 1] into %1 : tensor<1x1x4xf32> -> tensor<1x1x1x4x1xf32>
    %cast = tensor.cast %pack : tensor<1x1x1x4x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

