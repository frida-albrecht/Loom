module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-60> : tensor<6x4xi64>}> : () -> tensor<6x4xi64>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<6x4xi64>) -> tensor<1x4xi64>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = tosa.negate %1, %2, %3 : (tensor<1x4xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<1x4xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x4xi64>}> : () -> tensor<1x4xi64>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<1x4xi64>, tensor<1x4xi64>) -> tensor<1x4xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1x4xi64>}> : () -> tensor<1x4xi64>
    %clamped_shift = tosa.minimum %clamped_lower, %c63 : (tensor<1x4xi64>, tensor<1x4xi64>) -> tensor<1x4xi64>
    %5 = tosa.logical_left_shift %4, %clamped_shift : (tensor<1x4xi64>, tensor<1x4xi64>) -> tensor<1x4xi64>
    %cast = tensor.cast %5 : tensor<1x4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}