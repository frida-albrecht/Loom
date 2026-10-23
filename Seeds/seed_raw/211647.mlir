module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-96> : tensor<4x9x10xi64>}> : () -> tensor<4x9x10xi64>
    %1 = "tosa.const"() <{values = dense<135> : tensor<4x99x10xi64>}> : () -> tensor<4x99x10xi64>
    %2 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<4x9x10xi64>, tensor<4x99x10xi64>) -> tensor<4x108x10xi64>
    %3 = tosa.clz %2 : (tensor<4x108x10xi64>) -> tensor<4x108x10xi64>
    %cast = tensor.cast %3 : tensor<4x108x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

