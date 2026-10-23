module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.707000e+01> : tensor<1x1x3x1x1xf32>}> : () -> tensor<1x1x3x1x1xf32>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %0 low[0, 1, 0, %c0, 0] high[0, 0, 0, %c0, 2] {
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<1x1x3x1x1xf32> to tensor<1x2x3x1x3xf32>
    %cast = tensor.cast %padded : tensor<1x2x3x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

