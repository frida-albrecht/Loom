module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-85> : tensor<7xi64>}> : () -> tensor<7xi64>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<7xi64>) -> tensor<1xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1xi64>}> : () -> tensor<1xi64>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %clamped_shift = tosa.minimum %clamped_lower, %c63 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %2 = tosa.logical_left_shift %1, %clamped_shift : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %cast = tensor.cast %2 : tensor<1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}