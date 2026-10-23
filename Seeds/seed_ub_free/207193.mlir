module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.400000e+01> : tensor<7x3x5x4xf32>}> : () -> tensor<7x3x5x4xf32>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<7x3x5x4xf32>) -> tensor<1x3x5x4xf32>
    %2 = tosa.sub %1, %1 : (tensor<1x3x5x4xf32>, tensor<1x3x5x4xf32>) -> tensor<1x3x5x4xf32>
    %3 = tosa.reduce_min %2 {axis = 2 : i32} : (tensor<1x3x5x4xf32>) -> tensor<1x3x1x4xf32>
    %4 = tosa.argmax %3 {axis = 3 : i32} : (tensor<1x3x1x4xf32>) -> tensor<1x3x1xi32>
    %a0 = "tosa.const"() <{values = dense<1> : tensor<1x3x1xi32>}> : () -> tensor<1x3x1xi32>
    %a1 = tosa.maximum %4, %a0 : (tensor<1x3x1xi32>, tensor<1x3x1xi32>) -> tensor<1x3x1xi32>
    %5 = tosa.intdiv %4, %a1 : (tensor<1x3x1xi32>, tensor<1x3x1xi32>) -> tensor<1x3x1xi32>
    %6 = tosa.bitwise_or %5, %5 : (tensor<1x3x1xi32>, tensor<1x3x1xi32>) -> tensor<1x3x1xi32>
    %cast = tensor.cast %6 : tensor<1x3x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}