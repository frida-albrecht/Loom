module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-149> : tensor<9x8xi64>}> : () -> tensor<9x8xi64>
    %1 = "tosa.const"() <{values = dense<190> : tensor<1x8xi64>}> : () -> tensor<1x8xi64>
    %2 = tosa.sub %0, %1 : (tensor<9x8xi64>, tensor<1x8xi64>) -> tensor<9x8xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = tosa.negate %2, %3, %4 : (tensor<9x8xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<9x8xi64>
    %6 = tosa.minimum %5, %5 : (tensor<9x8xi64>, tensor<9x8xi64>) -> tensor<9x8xi64>
    %7 = tosa.minimum %6, %6 : (tensor<9x8xi64>, tensor<9x8xi64>) -> tensor<9x8xi64>
    %8 = tosa.reduce_min %7 {axis = 0 : i32} : (tensor<9x8xi64>) -> tensor<1x8xi64>
    %9 = tosa.minimum %8, %8 : (tensor<1x8xi64>, tensor<1x8xi64>) -> tensor<1x8xi64>
    %cast = tensor.cast %9 : tensor<1x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

