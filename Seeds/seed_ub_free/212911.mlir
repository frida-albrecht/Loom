module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.501800e+02> : tensor<8x5x6xf32>}> : () -> tensor<8x5x6xf32>
    %1 = "tosa.const"() <{values = dense<-17> : tensor<6xi64>}> : () -> tensor<6xi64>
    %2 = "tosa.const"() <{values = dense<-61> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = tosa.floor %0 : (tensor<8x5x6xf32>) -> tensor<8x5x6xf32>
    %4 = tosa.add %3, %3 : (tensor<8x5x6xf32>, tensor<8x5x6xf32>) -> tensor<8x5x6xf32>
    %5 = tosa.reduce_product %4 {axis = 0 : i32} : (tensor<8x5x6xf32>) -> tensor<1x5x6xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1xi64>}> : () -> tensor<1xi64>
    %s1 = tosa.maximum %2, %c0 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %s2 = tosa.minimum %s1, %c63 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %6 = tosa.logical_left_shift %1, %s2 : (tensor<6xi64>, tensor<1xi64>) -> tensor<6xi64>
    %cast = tensor.cast %5 : tensor<1x5x6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<6xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}