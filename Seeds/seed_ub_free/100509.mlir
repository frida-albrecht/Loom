module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.062000e+01> : tensor<4x5xf32>}> : () -> tensor<4x5xf32>
    %cst = arith.constant 1.369100e+02 : f32
    %padded = tensor.pad %0 low[3, 7] high[7, 8] {
    ^bb0(%arg0: index, %arg1: index):
      tensor.yield %cst : f32
    } : tensor<4x5xf32> to tensor<14x20xf32>
    %extracted_slice = tensor.extract_slice %padded[1, 3] [2, 3] [1, 1] : tensor<14x20xf32> to tensor<2x3xf32>
    %cast = tensor.cast %extracted_slice : tensor<2x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

