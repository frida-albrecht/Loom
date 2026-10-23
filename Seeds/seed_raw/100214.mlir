module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<19> : tensor<2x3x4x5x6x7x8x9xi32>}> : () -> tensor<2x3x4x5x6x7x8x9xi32>
    %collapsed = tensor.collapse_shape %0 [[0], [1, 2], [3], [4, 5, 6], [7]] : tensor<2x3x4x5x6x7x8x9xi32> into tensor<2x12x5x336x9xi32>
    %c0_i32 = arith.constant 0 : i32
    %padded = tensor.pad %collapsed low[1, 0, 8, 0, 3] high[5, 0, 4, 0, 2] {
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %c0_i32 : i32
    } : tensor<2x12x5x336x9xi32> to tensor<8x12x17x336x14xi32>
    %cast = tensor.cast %padded : tensor<8x12x17x336x14xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

