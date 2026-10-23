module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<170> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<68> : tensor<9x7x8x8xi16>}> : () -> tensor<9x7x8x8xi16>
    %2 = "tosa.const"() <{values = dense<190> : tensor<9x7x7x8xi16>}> : () -> tensor<9x7x7x8xi16>
    %3 = tosa.clz %0 : (tensor<i64>) -> tensor<i64>
    %4 = tosa.sub %3, %3 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %5 = tosa.concat %1, %2 {axis = 2 : i32} : (tensor<9x7x8x8xi16>, tensor<9x7x7x8xi16>) -> tensor<9x7x15x8xi16>
    %cast = tensor.cast %4 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<9x7x15x8xi16> to tensor<*xi16>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

