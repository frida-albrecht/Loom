module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-157> : tensor<1x10x1xi64>}> : () -> tensor<1x10x1xi64>
    %1 = "tosa.const"() <{values = dense<-187> : tensor<1x10x1xi64>}> : () -> tensor<1x10x1xi64>
    %2 = tosa.bitwise_or %0, %1 : (tensor<1x10x1xi64>, tensor<1x10x1xi64>) -> tensor<1x10x1xi64>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<1x10x1xi64>, tensor<1x10x1xi64>) -> tensor<2x10x1xi64>
    %cast = tensor.cast %3 : tensor<2x10x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

