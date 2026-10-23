module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<84> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<15> : tensor<9x6x5xi8>}> : () -> tensor<9x6x5xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = tosa.negate %0, %2, %3 : (tensor<i64>, tensor<1xi64>, tensor<1xi64>) -> tensor<i64>
    %5 = tosa.reverse %1 {axis = 2 : i32} : (tensor<9x6x5xi8>) -> tensor<9x6x5xi8>
    %6 = tosa.bitwise_or %4, %4 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %5 : tensor<9x6x5xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<i64> to tensor<*xi64>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

