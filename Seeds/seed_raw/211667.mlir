module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.396700e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = "tosa.const"() <{values = dense<1.862500e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<-2> : tensor<6x1x6x7xi8>}> : () -> tensor<6x1x6x7xi8>
    %3 = "tosa.const"() <{values = dense<-13> : tensor<6x1x1x7xi8>}> : () -> tensor<6x1x1x7xi8>
    %4 = tosa.sub %0, %1 : (tensor<3xf32>, tensor<1xf32>) -> tensor<3xf32>
    %5 = tosa.bitwise_xor %2, %3 : (tensor<6x1x6x7xi8>, tensor<6x1x1x7xi8>) -> tensor<6x1x6x7xi8>
    %6 = tosa.log %4 : (tensor<3xf32>) -> tensor<3xf32>
    %7 = tosa.arithmetic_right_shift %5, %5 {round = false} : (tensor<6x1x6x7xi8>, tensor<6x1x6x7xi8>) -> tensor<6x1x6x7xi8>
    %8 = tosa.const_shape  {values = dense<252> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.reshape %7, %8 : (tensor<6x1x6x7xi8>, !tosa.shape<1>) -> tensor<252xi8>
    %10 = tosa.logical_left_shift %5, %7 : (tensor<6x1x6x7xi8>, tensor<6x1x6x7xi8>) -> tensor<6x1x6x7xi8>
    %11 = tosa.bitwise_and %9, %9 : (tensor<252xi8>, tensor<252xi8>) -> tensor<252xi8>
    %12 = tosa.pow %4, %6 : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    %13 = tosa.maximum %11, %9 : (tensor<252xi8>, tensor<252xi8>) -> tensor<252xi8>
    %14 = tosa.bitwise_or %13, %11 : (tensor<252xi8>, tensor<252xi8>) -> tensor<252xi8>
    %cast = tensor.cast %10 : tensor<6x1x6x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %12 : tensor<3xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %14 : tensor<252xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}

