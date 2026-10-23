module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.840000e+01> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = "tosa.const"() <{values = dense<-63> : tensor<i64>}> : () -> tensor<i64>
    %2 = tosa.log %0 : (tensor<8xf32>) -> tensor<8xf32>
    %3 = tosa.clz %1 : (tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %2 : tensor<8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %3 : tensor<i64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

