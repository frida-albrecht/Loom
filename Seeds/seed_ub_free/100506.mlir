module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.394000e+01> : tensor<4x5xf32>}> : () -> tensor<4x5xf32>
    %cst = arith.constant 3.804000e+01 : f32
    %padded = tensor.pad %0 low[0, 0] high[7, 8] {
    ^bb0(%arg0: index, %arg1: index):
      tensor.yield %cst : f32
    } : tensor<4x5xf32> to tensor<11x13xf32>
    %extracted_slice = tensor.extract_slice %padded[1, 2] [2, 1] [1, 1] : tensor<11x13xf32> to tensor<2x1xf32>
    %cast = tensor.cast %extracted_slice : tensor<2x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

