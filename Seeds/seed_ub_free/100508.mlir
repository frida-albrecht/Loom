module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.558000e+01> : tensor<4x5xf32>}> : () -> tensor<4x5xf32>
    %cst = arith.constant -1.277300e+02 : f32
    %padded = tensor.pad %0 low[0, 0] high[7, 8] {
    ^bb0(%arg0: index, %arg1: index):
      tensor.yield %cst : f32
    } : tensor<4x5xf32> to tensor<11x13xf32>
    %extracted_slice = tensor.extract_slice %padded[4, 5] [2, 4] [1, 1] : tensor<11x13xf32> to tensor<2x4xf32>
    %cast = tensor.cast %extracted_slice : tensor<2x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

