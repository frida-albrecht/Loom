module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.234500e+02> : tensor<28x2x16xf32>}> : () -> tensor<28x2x16xf32>
    %1 = "tosa.const"() <{values = dense<-7.116000e+01> : tensor<28x32xf32>}> : () -> tensor<28x32xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 1] inner_dims_pos = [1] inner_tiles = [16] into %1 : tensor<28x2x16xf32> -> tensor<28x32xf32>
    %extracted_slice = tensor.extract_slice %unpack[0, 1] [28, 28] [1, 1] : tensor<28x32xf32> to tensor<28x28xf32>
    %cast = tensor.cast %extracted_slice : tensor<28x28xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

