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
    // Fix for tosa.arithmetic_right_shift: shift amount for i8 must be in [0, 7].
    // Input %5 (dense<13>) as shift amount violates this.
    %a0 = "tosa.const"() <{values = dense<0> : tensor<6x1x6x7xi8>}> : () -> tensor<6x1x6x7xi8>
    %a1 = "tosa.const"() <{values = dense<7> : tensor<6x1x6x7xi8>}> : () -> tensor<6x1x6x7xi8>
    %a2 = tosa.maximum %5, %a0 : (tensor<6x1x6x7xi8>, tensor<6x1x6x7xi8>) -> tensor<6x1x6x7xi8>
    %a3 = tosa.minimum %a2, %a1 : (tensor<6x1x6x7xi8>, tensor<6x1x6x7xi8>) -> tensor<6x1x6x7xi8>
    %7 = tosa.arithmetic_right_shift %5, %a3 {round = false} : (tensor<6x1x6x7xi8>, tensor<6x1x6x7xi8>) -> tensor<6x1x6x7xi8>
    %8 = tosa.const_shape  {values = dense<252> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.reshape %7, %8 : (tensor<6x1x6x7xi8>, !tosa.shape<1>) -> tensor<252xi8>
    %10 = tosa.logical_left_shift %5, %7 : (tensor<6x1x6x7xi8>, tensor<6x1x6x7xi8>) -> tensor<6x1x6x7xi8>
    %11 = tosa.bitwise_and %9, %9 : (tensor<252xi8>, tensor<252xi8>) -> tensor<252xi8>
    // Fix for tosa.pow: base (%4) must be >= 0, and exponent (%6) must not be NaN or infinite.
    // %4 is dense<-325.92>, %6 (log of %4) is dense<NaN>.
    %b0 = "tosa.const"() <{values = dense<0.0> : tensor<3xf32>}> : () -> tensor<3xf32>
    %b1 = tosa.maximum %4, %b0 : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    %b2 = "tosa.const"() <{values = dense<1.0> : tensor<3xf32>}> : () -> tensor<3xf32>
    %12 = tosa.pow %b1, %b2 : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
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