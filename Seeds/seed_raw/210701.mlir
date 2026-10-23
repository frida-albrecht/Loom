module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2> : tensor<4x8x3xi8>}> : () -> tensor<4x8x3xi8>
    %1 = "tosa.const"() <{values = dense<-12> : tensor<3x2xi64>}> : () -> tensor<3x2xi64>
    %2 = "tosa.const"() <{values = dense<-1.725000e+02> : tensor<8xf32>}> : () -> tensor<8xf32>
    %3 = tosa.const_shape  {values = dense<0> : tensor<6xindex>} : () -> !tosa.shape<6>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.pad %0, %3, %4 : (tensor<4x8x3xi8>, !tosa.shape<6>, tensor<1xi8>) -> tensor<4x8x3xi8>
    %6 = tosa.arithmetic_right_shift %5, %5 {round = true} : (tensor<4x8x3xi8>, tensor<4x8x3xi8>) -> tensor<4x8x3xi8>
    %7 = tosa.ceil %2 : (tensor<8xf32>) -> tensor<8xf32>
    %8 = tosa.reduce_max %6 {axis = 0 : i32} : (tensor<4x8x3xi8>) -> tensor<1x8x3xi8>
    %9 = tosa.abs %7 : (tensor<8xf32>) -> tensor<8xf32>
    %10 = tosa.reduce_min %8 {axis = 2 : i32} : (tensor<1x8x3xi8>) -> tensor<1x8x1xi8>
    %11 = tosa.sigmoid %9 : (tensor<8xf32>) -> tensor<8xf32>
    %12 = tosa.floor %11 : (tensor<8xf32>) -> tensor<8xf32>
    %cast = tensor.cast %10 : tensor<1x8x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %12 : tensor<8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

