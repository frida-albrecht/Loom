module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<133> : tensor<3x6x8x7xi64>}> : () -> tensor<3x6x8x7xi64>
    %1 = "tosa.const"() <{values = dense<-67> : tensor<3x1x8x1xi64>}> : () -> tensor<3x1x8x1xi64>
    %2 = tosa.bitwise_or %0, %1 : (tensor<3x6x8x7xi64>, tensor<3x1x8x1xi64>) -> tensor<3x6x8x7xi64>
    %3 = tosa.const_shape  {values = dense<1008> : tensor<1xindex>} : () -> !tosa.shape<1>
    %4 = tosa.reshape %2, %3 : (tensor<3x6x8x7xi64>, !tosa.shape<1>) -> tensor<1008xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1008xi64>}> : () -> tensor<1008xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1008xi64>}> : () -> tensor<1008xi64>
    %a1 = tosa.maximum %4, %c0 : (tensor<1008xi64>, tensor<1008xi64>) -> tensor<1008xi64>
    %a2 = tosa.minimum %a1, %c63 : (tensor<1008xi64>, tensor<1008xi64>) -> tensor<1008xi64>
    %5 = tosa.logical_left_shift %4, %a2 : (tensor<1008xi64>, tensor<1008xi64>) -> tensor<1008xi64>
    %6 = tosa.reduce_sum %5 {axis = 0 : i32} : (tensor<1008xi64>) -> tensor<1xi64>
    %cast = tensor.cast %6 : tensor<1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}