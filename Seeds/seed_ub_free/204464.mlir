module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<116> : tensor<2xi64>}> : () -> tensor<2xi64>
    %1 = "tosa.const"() <{values = dense<76.0899963> : tensor<4x3x5xf32>}> : () -> tensor<4x3x5xf32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<2xi64>) -> tensor<1xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1xi64>}> : () -> tensor<1xi64>
    %l1 = tosa.maximum %2, %c0 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %l2 = tosa.minimum %l1, %c63 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %3 = tosa.logical_left_shift %2, %l2 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %4 = tosa.bitwise_and %3, %2 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %5 = tosa.ceil %1 : (tensor<4x3x5xf32>) -> tensor<4x3x5xf32>
    %cast = tensor.cast %4 : tensor<1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<4x3x5xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}