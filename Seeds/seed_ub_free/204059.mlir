module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.120000e+00> : tensor<3x6xf32>}> : () -> tensor<3x6xf32>
    %1 = "tosa.const"() <{values = dense<79> : tensor<2x2xi64>}> : () -> tensor<2x2xi64>
    %2 = "tosa.const"() <{values = dense<-4> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<18> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<7> : tensor<2x3x8x2xi32>}> : () -> tensor<2x3x8x2xi32>
    %5 = "tosa.const"() <{values = dense<-106> : tensor<1x1x1x2xi32>}> : () -> tensor<1x1x1x2xi32>
    %6 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = tosa.pad %0, %6, %7 : (tensor<3x6xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<3x6xf32>
    %9 = tosa.sigmoid %8 : (tensor<3x6xf32>) -> tensor<3x6xf32>
    %c18 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c19 = "tosa.const"() <{values = dense<7> : tensor<1xi8>}> : () -> tensor<1xi8>
    %t20 = tosa.maximum %3, %c18 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %t21 = tosa.minimum %t20, %c19 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %10 = tosa.logical_right_shift %2, %t21 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %11 = tosa.logical_left_shift %10, %10 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %12 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %13 = tosa.tile %10, %12 : (tensor<1xi8>, !tosa.shape<1>) -> tensor<1xi8>
    %14 = tosa.reduce_max %13 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<1xi8>
    %15 = tosa.ceil %9 : (tensor<3x6xf32>) -> tensor<3x6xf32>
    %16 = tosa.intdiv %4, %5 : (tensor<2x3x8x2xi32>, tensor<1x1x1x2xi32>) -> tensor<2x3x8x2xi32>
    %17 = tosa.argmax %11 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<i32>
    %cast = tensor.cast %14 : tensor<1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %15 : tensor<3x6xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %16 : tensor<2x3x8x2xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %17 : tensor<i32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}