module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-186> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<9.469000e+01> : tensor<3x10xf32>}> : () -> tensor<3x10xf32>
    %2 = tosa.bitwise_not %0 : (tensor<i16>) -> tensor<i16>
    %3 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %4 = tosa.transpose %1 {perms = array<i32: 0, 1>} : (tensor<3x10xf32>) -> tensor<3x10xf32>
    %5 = tosa.bitwise_or %2, %2 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %6 = tosa.argmax %4 {axis = 1 : i32} : (tensor<3x10xf32>) -> tensor<3xi32>
    %cast = tensor.cast %5 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<3xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

