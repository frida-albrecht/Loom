module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-195> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<137> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<-23> : tensor<2x10x9x9xi32>}> : () -> tensor<2x10x9x9xi32>
    %3 = "tosa.const"() <{values = dense<-196> : tensor<1x1x9x1xi32>}> : () -> tensor<1x1x9x1xi32>
    %4 = tosa.sub %0, %1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %5 = tosa.intdiv %2, %3 : (tensor<2x10x9x9xi32>, tensor<1x1x9x1xi32>) -> tensor<2x10x9x9xi32>
    %6 = tosa.intdiv %5, %5 : (tensor<2x10x9x9xi32>, tensor<2x10x9x9xi32>) -> tensor<2x10x9x9xi32>
    %cast = tensor.cast %4 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<2x10x9x9xi32> to tensor<*xi32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

