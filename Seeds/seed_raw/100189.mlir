module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = tensor.empty() : tensor<384x512xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = tensor.empty() : tensor<24x32x16x16xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%0 : tensor<384x512xf32>) -> tensor<384x512xf32>
    %pack = linalg.pack %2 inner_dims_pos = [0, 1] inner_tiles = [16, 16] into %1 : tensor<384x512xf32> -> tensor<24x32x16x16xf32>
    %cast = tensor.cast %pack : tensor<24x32x16x16xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

