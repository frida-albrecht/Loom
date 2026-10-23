module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.265000e+01> : tensor<9x1x8x1xf32>}> : () -> tensor<9x1x8x1xf32>
    %1 = tosa.floor %0 : (tensor<9x1x8x1xf32>) -> tensor<9x1x8x1xf32>
    %2 = tosa.reduce_min %1 {axis = 3 : i32} : (tensor<9x1x8x1xf32>) -> tensor<9x1x8x1xf32>
    %3 = tosa.rsqrt %2 : (tensor<9x1x8x1xf32>) -> tensor<9x1x8x1xf32>
    %4 = tosa.reduce_product %3 {axis = 2 : i32} : (tensor<9x1x8x1xf32>) -> tensor<9x1x1x1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = tosa.negate %4, %5, %6 : (tensor<9x1x1x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<9x1x1x1xf32>
    %8 = tosa.sigmoid %7 : (tensor<9x1x1x1xf32>) -> tensor<9x1x1x1xf32>
    %cast = tensor.cast %8 : tensor<9x1x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

