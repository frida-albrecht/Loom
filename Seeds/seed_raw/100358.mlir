module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<400x273xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<400x273xf32>) -> tensor<400x273xf32>
    %padded = tensor.pad %1 low[4, 1] high[8, 2] {
    ^bb0(%arg0: index, %arg1: index):
      tensor.yield %cst_0 : f32
    } : tensor<400x273xf32> to tensor<412x276xf32>
    %cast = tensor.cast %padded : tensor<412x276xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

