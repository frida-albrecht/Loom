module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-165> : tensor<4xi64>}> : () -> tensor<4xi64>
    %1 = "tosa.const"() <{values = dense<-195> : tensor<18xi64>}> : () -> tensor<18xi64>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<4xi64>, tensor<18xi64>) -> tensor<22xi64>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<22xi64>) -> tensor<22xi64>
    %cast = tensor.cast %3 : tensor<22xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

