module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<2x4x4x7xi8>}> : () -> tensor<2x4x4x7xi8>
    %1 = "tosa.const"() <{values = dense<-14> : tensor<2x4x1x1xi8>}> : () -> tensor<2x4x1x1xi8>
    %2 = tosa.minimum %0, %1 : (tensor<2x4x4x7xi8>, tensor<2x4x1x1xi8>) -> tensor<2x4x4x7xi8>
    %3 = tosa.reduce_max %2 {axis = 2 : i32} : (tensor<2x4x4x7xi8>) -> tensor<2x4x1x7xi8>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<2x4x1x7xi8>, tensor<2x4x1x7xi8>) -> tensor<2x4x1x7xi8>
    %5 = tosa.concat %4, %3 {axis = 2 : i32} : (tensor<2x4x1x7xi8>, tensor<2x4x1x7xi8>) -> tensor<2x4x2x7xi8>
    %6 = tosa.reduce_min %5 {axis = 1 : i32} : (tensor<2x4x2x7xi8>) -> tensor<2x1x2x7xi8>
    %7 = tosa.minimum %6, %6 : (tensor<2x1x2x7xi8>, tensor<2x1x2x7xi8>) -> tensor<2x1x2x7xi8>
    %8 = tosa.const_shape  {values = dense<[1, 3, 2, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %9 = tosa.tile %7, %8 : (tensor<2x1x2x7xi8>, !tosa.shape<4>) -> tensor<2x3x4x14xi8>
    %cast = tensor.cast %9 : tensor<2x3x4x14xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

