module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-106> : tensor<3xi64>}> : () -> tensor<3xi64>
    %1 = "tosa.const"() <{values = dense<178> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = "tosa.const"() <{values = dense<1.961100e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %3 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<3xi64>, tensor<1xi64>) -> tensor<3xi64>
    %4 = tosa.concat %3, %3 {axis = 0 : i32} : (tensor<3xi64>, tensor<3xi64>) -> tensor<6xi64>
    %5 = tosa.reciprocal %2 : (tensor<6xf32>) -> tensor<6xf32>
    %6 = tosa.bitwise_not %4 : (tensor<6xi64>) -> tensor<6xi64>
    %cast = tensor.cast %5 : tensor<6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<6xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

