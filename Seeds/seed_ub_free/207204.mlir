module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-151> : tensor<3xi64>}> : () -> tensor<3xi64>
    %1 = "tosa.const"() <{values = dense<25> : tensor<3xi64>}> : () -> tensor<3xi64>
    %2 = tosa.add %0, %1 : (tensor<3xi64>, tensor<3xi64>) -> tensor<3xi64>
    %3 = tosa.bitwise_or %2, %2 : (tensor<3xi64>, tensor<3xi64>) -> tensor<3xi64>
    %4 = tosa.reduce_sum %3 {axis = 0 : i32} : (tensor<3xi64>) -> tensor<1xi64>
    %5 = tosa.clamp %4 {max_val = 55 : i64, min_val = -16 : i64} : (tensor<1xi64>) -> tensor<1xi64>
    %cast = tensor.cast %5 : tensor<1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

