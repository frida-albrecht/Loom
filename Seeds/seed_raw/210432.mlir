module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-112> : tensor<2x4xi64>}> : () -> tensor<2x4xi64>
    %1 = "tosa.const"() <{values = dense<-173> : tensor<1x4xi64>}> : () -> tensor<1x4xi64>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<2x4xi64>, tensor<1x4xi64>) -> tensor<2x4xi64>
    %3 = tosa.minimum %2, %2 : (tensor<2x4xi64>, tensor<2x4xi64>) -> tensor<2x4xi64>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<2x4xi64>, tensor<2x4xi64>) -> tensor<2x4xi64>
    %5 = tosa.concat %4, %3 {axis = 1 : i32} : (tensor<2x4xi64>, tensor<2x4xi64>) -> tensor<2x8xi64>
    %cast = tensor.cast %5 : tensor<2x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

