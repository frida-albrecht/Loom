module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.880400e+02> : tensor<8x1x4xf32>}> : () -> tensor<8x1x4xf32>
    %1 = tosa.reciprocal %0 : (tensor<8x1x4xf32>) -> tensor<8x1x4xf32>
    %2 = tosa.pow %1, %1 : (tensor<8x1x4xf32>, tensor<8x1x4xf32>) -> tensor<8x1x4xf32>
    %3 = tosa.reduce_sum %2 {axis = 2 : i32} : (tensor<8x1x4xf32>) -> tensor<8x1x1xf32>
    %4 = tosa.reduce_min %3 {axis = 1 : i32} : (tensor<8x1x1xf32>) -> tensor<8x1x1xf32>
    %5 = tosa.log %4 : (tensor<8x1x1xf32>) -> tensor<8x1x1xf32>
    %cast = tensor.cast %5 : tensor<8x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

