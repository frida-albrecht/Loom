module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-81> : tensor<5x6x2x7xi64>}> : () -> tensor<5x6x2x7xi64>
    %1 = "tosa.const"() <{values = dense<177> : tensor<5x6x1x7xi64>}> : () -> tensor<5x6x1x7xi64>
    %2 = "tosa.const"() <{values = dense<-23> : tensor<7xi32>}> : () -> tensor<7xi32>
    %3 = "tosa.const"() <{values = dense<75> : tensor<1xi32>}> : () -> tensor<1xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<5x6x1x7xi64>}> : () -> tensor<5x6x1x7xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<5x6x1x7xi64>}> : () -> tensor<5x6x1x7xi64>
    %s0 = tosa.maximum %1, %c0 : (tensor<5x6x1x7xi64>, tensor<5x6x1x7xi64>) -> tensor<5x6x1x7xi64>
    %s1 = tosa.minimum %s0, %c63 : (tensor<5x6x1x7xi64>, tensor<5x6x1x7xi64>) -> tensor<5x6x1x7xi64>
    %4 = tosa.logical_right_shift %0, %s1 : (tensor<5x6x2x7xi64>, tensor<5x6x1x7xi64>) -> tensor<5x6x2x7xi64>
    %5 = tosa.add %4, %4 : (tensor<5x6x2x7xi64>, tensor<5x6x2x7xi64>) -> tensor<5x6x2x7xi64>
    %6 = tosa.minimum %5, %5 : (tensor<5x6x2x7xi64>, tensor<5x6x2x7xi64>) -> tensor<5x6x2x7xi64>
    %7 = tosa.intdiv %2, %3 : (tensor<7xi32>, tensor<1xi32>) -> tensor<7xi32>
    %8 = tosa.clz %7 : (tensor<7xi32>) -> tensor<7xi32>
    %9 = tosa.arithmetic_right_shift %8, %7 {round = false} : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %cast = tensor.cast %6 : tensor<5x6x2x7xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %9 : tensor<7xi32> to tensor<*xi32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}