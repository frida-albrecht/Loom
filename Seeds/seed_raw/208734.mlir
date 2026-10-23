module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<199> : tensor<4x5xi64>}> : () -> tensor<4x5xi64>
    %1 = "tosa.const"() <{values = dense<-140> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<4x5xi64>, tensor<1x1xi64>) -> tensor<4x5xi64>
    %3 = tosa.clz %2 : (tensor<4x5xi64>) -> tensor<4x5xi64>
    %4 = tosa.reverse %3 {axis = 0 : i32} : (tensor<4x5xi64>) -> tensor<4x5xi64>
    %5 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<4x5xi64>) -> tensor<4x1xi64>
    %cast = tensor.cast %5 : tensor<4x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

