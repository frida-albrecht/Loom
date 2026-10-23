module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<91> : tensor<1x5x1x5xi64>}> : () -> tensor<1x5x1x5xi64>
    %1 = "tosa.const"() <{values = dense<-119> : tensor<1x5x1x5xi64>}> : () -> tensor<1x5x1x5xi64>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<1x5x1x5xi64>, tensor<1x5x1x5xi64>) -> tensor<1x5x1x5xi64>
    %3 = tosa.identity %2 : (tensor<1x5x1x5xi64>) -> tensor<1x5x1x5xi64>
    %4 = tosa.reduce_sum %3 {axis = 0 : i32} : (tensor<1x5x1x5xi64>) -> tensor<1x5x1x5xi64>
    %cast = tensor.cast %4 : tensor<1x5x1x5xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

