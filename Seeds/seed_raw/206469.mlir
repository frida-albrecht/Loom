module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-193> : tensor<1x6x6xi64>}> : () -> tensor<1x6x6xi64>
    %1 = "tosa.const"() <{values = dense<-38> : tensor<1x6x6xi64>}> : () -> tensor<1x6x6xi64>
    %2 = tosa.maximum %0, %1 : (tensor<1x6x6xi64>, tensor<1x6x6xi64>) -> tensor<1x6x6xi64>
    %3 = tosa.add %2, %2 : (tensor<1x6x6xi64>, tensor<1x6x6xi64>) -> tensor<1x6x6xi64>
    %4 = tosa.clamp %3 {max_val = 109 : i64, min_val = 2 : i64} : (tensor<1x6x6xi64>) -> tensor<1x6x6xi64>
    %5 = tosa.bitwise_not %4 : (tensor<1x6x6xi64>) -> tensor<1x6x6xi64>
    %cast = tensor.cast %5 : tensor<1x6x6xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

