module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-146> : tensor<6x10xi64>}> : () -> tensor<6x10xi64>
    %1 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<6x10xi64>, !tosa.shape<2>) -> tensor<12x30xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<12x30xi64>}> : () -> tensor<12x30xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<12x30xi64>}> : () -> tensor<12x30xi64>
    %s0 = tosa.maximum %2, %c0 : (tensor<12x30xi64>, tensor<12x30xi64>) -> tensor<12x30xi64>
    %s1 = tosa.minimum %s0, %c63 : (tensor<12x30xi64>, tensor<12x30xi64>) -> tensor<12x30xi64>
    %3 = tosa.logical_left_shift %2, %s1 : (tensor<12x30xi64>, tensor<12x30xi64>) -> tensor<12x30xi64>
    %cast = tensor.cast %3 : tensor<12x30xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}