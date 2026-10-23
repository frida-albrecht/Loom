module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-161> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<17> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<12> : tensor<1x4x7xi8>}> : () -> tensor<1x4x7xi8>
    %3 = "tosa.const"() <{values = dense<9> : tensor<1x4x1xi8>}> : () -> tensor<1x4x1xi8>
    %4 = tosa.sub %0, %1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %5 = tosa.maximum %2, %3 : (tensor<1x4x7xi8>, tensor<1x4x1xi8>) -> tensor<1x4x7xi8>
    %cast = tensor.cast %4 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<1x4x7xi8> to tensor<*xi8>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

