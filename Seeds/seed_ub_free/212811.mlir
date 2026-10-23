module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<26> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<-10> : tensor<2x5x1x5xi8>}> : () -> tensor<2x5x1x5xi8>
    %2 = tosa.clz %0 : (tensor<i16>) -> tensor<i16>
    %3 = tosa.reduce_sum %1 {axis = 1 : i32} : (tensor<2x5x1x5xi8>) -> tensor<2x1x1x5xi8>
    %cast = tensor.cast %2 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %3 : tensor<2x1x1x5xi8> to tensor<*xi8>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

