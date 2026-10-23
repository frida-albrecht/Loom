module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<122> : tensor<9x6x2xi64>}> : () -> tensor<9x6x2xi64>
    %1 = "tosa.const"() <{values = dense<-194> : tensor<9x1x2xi64>}> : () -> tensor<9x1x2xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<9x1x2xi64>}> : () -> tensor<9x1x2xi64>
    %s0 = tosa.maximum %1, %c0 : (tensor<9x1x2xi64>, tensor<9x1x2xi64>) -> tensor<9x1x2xi64>
    %c1 = "tosa.const"() <{values = dense<63> : tensor<9x1x2xi64>}> : () -> tensor<9x1x2xi64>
    %s1 = tosa.minimum %s0, %c1 : (tensor<9x1x2xi64>, tensor<9x1x2xi64>) -> tensor<9x1x2xi64>
    %2 = tosa.arithmetic_right_shift %0, %s1 {round = false} : (tensor<9x6x2xi64>, tensor<9x1x2xi64>) -> tensor<9x6x2xi64>
    %3 = tosa.concat %2, %2 {axis = 2 : i32} : (tensor<9x6x2xi64>, tensor<9x6x2xi64>) -> tensor<9x6x4xi64>
    %cast = tensor.cast %3 : tensor<9x6x4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}