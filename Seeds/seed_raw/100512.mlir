module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.632000e+01> : tensor<4x5xf32>}> : () -> tensor<4x5xf32>
    %cst = arith.constant 1.656700e+02 : f32
    %padded = tensor.pad %0 low[2, 3] high[7, 8] {
    ^bb0(%arg0: index, %arg1: index):
      tensor.yield %cst : f32
    } : tensor<4x5xf32> to tensor<13x16xf32>
    %extracted_slice = tensor.extract_slice %padded[1, 2] [7, 9] [1, 1] : tensor<13x16xf32> to tensor<7x9xf32>
    %cast = tensor.cast %extracted_slice : tensor<7x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

