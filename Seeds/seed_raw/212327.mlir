module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-192> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<-61> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<-18> : tensor<4x2x4xi8>}> : () -> tensor<4x2x4xi8>
    %3 = tosa.logical_left_shift %0, %1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %4 = tosa.bitwise_not %3 : (tensor<i16>) -> tensor<i16>
    %5 = tosa.bitwise_xor %4, %4 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %6 = tosa.reduce_max %2 {axis = 1 : i32} : (tensor<4x2x4xi8>) -> tensor<4x1x4xi8>
    %7 = tosa.reverse %6 {axis = 0 : i32} : (tensor<4x1x4xi8>) -> tensor<4x1x4xi8>
    %8 = tosa.reduce_min %6 {axis = 1 : i32} : (tensor<4x1x4xi8>) -> tensor<4x1x4xi8>
    %cast = tensor.cast %5 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<4x1x4xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %8 : tensor<4x1x4xi8> to tensor<*xi8>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}

