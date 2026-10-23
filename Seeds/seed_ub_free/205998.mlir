module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-143> : tensor<6x2xi64>}> : () -> tensor<6x2xi64>
    %1 = "tosa.const"() <{values = dense<193> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %c0 = "tosa.const"() <{values = dense<63> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %s0 = tosa.minimum %1, %c0 : (tensor<1x2xi64>, tensor<1x2xi64>) -> tensor<1x2xi64>
    %2 = tosa.arithmetic_right_shift %0, %s0 {round = true} : (tensor<6x2xi64>, tensor<1x2xi64>) -> tensor<6x2xi64>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<6x2xi64>}> : () -> tensor<6x2xi64>
    %c2 = "tosa.const"() <{values = dense<63> : tensor<6x2xi64>}> : () -> tensor<6x2xi64>
    %s1 = tosa.maximum %2, %c1 : (tensor<6x2xi64>, tensor<6x2xi64>) -> tensor<6x2xi64>
    %s2 = tosa.minimum %s1, %c2 : (tensor<6x2xi64>, tensor<6x2xi64>) -> tensor<6x2xi64>
    %3 = tosa.logical_left_shift %2, %s2 : (tensor<6x2xi64>, tensor<6x2xi64>) -> tensor<6x2xi64>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<6x2xi64>) -> tensor<1x2xi64>
    %5 = tosa.clamp %4 {max_val = 114 : i64, min_val = 19 : i64} : (tensor<1x2xi64>) -> tensor<1x2xi64>
    %6 = tosa.argmax %5 {axis = 0 : i32} : (tensor<1x2xi64>) -> tensor<2xi32>
    %cast = tensor.cast %6 : tensor<2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}