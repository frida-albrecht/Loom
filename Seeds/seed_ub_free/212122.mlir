module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-185> : tensor<9x10x4x7xi64>}> : () -> tensor<9x10x4x7xi64>
    %1 = "tosa.const"() <{values = dense<-1.282600e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %2 = tosa.reduce_sum %0 {axis = 3 : i32} : (tensor<9x10x4x7xi64>) -> tensor<9x10x4x1xi64>
    %3 = tosa.exp %1 : (tensor<7xf32>) -> tensor<7xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<9x10x4x1xi64>}> : () -> tensor<9x10x4x1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<9x10x4x1xi64>}> : () -> tensor<9x10x4x1xi64>
    %s0 = tosa.maximum %2, %c0 : (tensor<9x10x4x1xi64>, tensor<9x10x4x1xi64>) -> tensor<9x10x4x1xi64>
    %s1 = tosa.minimum %s0, %c63 : (tensor<9x10x4x1xi64>, tensor<9x10x4x1xi64>) -> tensor<9x10x4x1xi64>
    %4 = tosa.arithmetic_right_shift %2, %s1 {round = false} : (tensor<9x10x4x1xi64>, tensor<9x10x4x1xi64>) -> tensor<9x10x4x1xi64>
    %5 = tosa.minimum %4, %2 : (tensor<9x10x4x1xi64>, tensor<9x10x4x1xi64>) -> tensor<9x10x4x1xi64>
    %6 = tosa.log %3 : (tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %5 : tensor<9x10x4x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}