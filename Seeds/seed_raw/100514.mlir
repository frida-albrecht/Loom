module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.816000e+02> : tensor<8x16x4xf32>}> : () -> tensor<8x16x4xf32>
    %cst = arith.constant -1.777400e+02 : f32
    %padded = tensor.pad %0 low[0, 2, 0] high[0, 0, 0] {
    ^bb0(%arg0: index, %arg1: index, %arg2: index):
      tensor.yield %cst : f32
    } : tensor<8x16x4xf32> to tensor<8x18x4xf32>
    %extracted_slice = tensor.extract_slice %padded[0, 0, 0] [1, 16, 4] [1, 1, 1] : tensor<8x18x4xf32> to tensor<16x4xf32>
    %cast = tensor.cast %extracted_slice : tensor<16x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

