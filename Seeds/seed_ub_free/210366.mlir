module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.357000e+01> : tensor<7x2x6x4xf32>}> : () -> tensor<7x2x6x4xf32>
    %1 = "tosa.const"() <{values = dense<99> : tensor<i64>}> : () -> tensor<i64>
    %2 = tosa.sigmoid %0 : (tensor<7x2x6x4xf32>) -> tensor<7x2x6x4xf32>
    %3 = tosa.clz %1 : (tensor<i64>) -> tensor<i64>
    %4 = tosa.minimum %2, %2 : (tensor<7x2x6x4xf32>, tensor<7x2x6x4xf32>) -> tensor<7x2x6x4xf32>
    %5 = tosa.ceil %4 : (tensor<7x2x6x4xf32>) -> tensor<7x2x6x4xf32>
    %cast = tensor.cast %3 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<7x2x6x4xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

