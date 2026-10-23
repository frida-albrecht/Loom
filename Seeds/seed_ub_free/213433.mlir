module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-168> : tensor<8x7x2xi64>}> : () -> tensor<8x7x2xi64>
    %1 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 2, 1>} : (tensor<8x7x2xi64>) -> tensor<8x2x7xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = tosa.negate %2, %3, %4 : (tensor<8x2x7xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<8x2x7xi64>
    %cast = tensor.cast %5 : tensor<8x2x7xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

