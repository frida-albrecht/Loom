module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<61> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<92> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<6> : tensor<4xi8>}> : () -> tensor<4xi8>
    %3 = "tosa.const"() <{values = dense<-6> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i16>}> : () -> tensor<i16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<i16>}> : () -> tensor<i16>
    %clamped_lower_shift = tosa.maximum %1, %c0 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %clamped_shift = tosa.minimum %clamped_lower_shift, %c15 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %4 = tosa.logical_left_shift %0, %clamped_shift : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %c_neg6_4x = "tosa.const"() <{values = dense<-6> : tensor<4xi8>}> : () -> tensor<4xi8>
    %5 = tosa.maximum %2, %c_neg6_4x : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %cast = tensor.cast %4 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<4xi8> to tensor<*xi8>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}