module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.727000e+01> : tensor<8x7x1x2xf32>}> : () -> tensor<8x7x1x2xf32>
    %1 = tosa.log %0 : (tensor<8x7x1x2xf32>) -> tensor<8x7x1x2xf32>
    %2 = tosa.pow %1, %1 : (tensor<8x7x1x2xf32>, tensor<8x7x1x2xf32>) -> tensor<8x7x1x2xf32>
    %3 = tosa.sub %2, %2 : (tensor<8x7x1x2xf32>, tensor<8x7x1x2xf32>) -> tensor<8x7x1x2xf32>
    %4 = tosa.reduce_product %3 {axis = 1 : i32} : (tensor<8x7x1x2xf32>) -> tensor<8x1x1x2xf32>
    %5 = tosa.pow %4, %4 : (tensor<8x1x1x2xf32>, tensor<8x1x1x2xf32>) -> tensor<8x1x1x2xf32>
    %cast = tensor.cast %5 : tensor<8x1x1x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

