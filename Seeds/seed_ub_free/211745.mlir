module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<100> : tensor<4x3xi64>}> : () -> tensor<4x3xi64>
    %1 = "tosa.const"() <{values = dense<67> : tensor<4x59xi64>}> : () -> tensor<4x59xi64>
    %2 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<4x3xi64>, tensor<4x59xi64>) -> tensor<4x62xi64>
    %cast = tensor.cast %2 : tensor<4x62xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

