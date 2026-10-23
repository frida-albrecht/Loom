module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<178> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<125> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<-120> : tensor<3x4xi16>}> : () -> tensor<3x4xi16>
    %3 = tosa.bitwise_or %0, %1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %4 = tosa.abs %3 : (tensor<i64>) -> tensor<i64>
    %5 = tosa.bitwise_and %4, %4 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %6 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<3x4xi16>) -> tensor<1x4xi16>
    %7 = tosa.reduce_product %6 {axis = 0 : i32} : (tensor<1x4xi16>) -> tensor<1x4xi16>
    %cast = tensor.cast %5 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<1x4xi16> to tensor<*xi16>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

