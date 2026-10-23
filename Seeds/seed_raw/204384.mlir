module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<14> : tensor<10x8x3xi8>}> : () -> tensor<10x8x3xi8>
    %1 = "tosa.const"() <{values = dense<8> : tensor<1x8x1xi8>}> : () -> tensor<1x8x1xi8>
    %2 = "tosa.const"() <{values = dense<1.507700e+02> : tensor<7x3x8x6xf32>}> : () -> tensor<7x3x8x6xf32>
    %3 = "tosa.const"() <{values = dense<42> : tensor<7x5x8xi32>}> : () -> tensor<7x5x8xi32>
    %4 = "tosa.const"() <{values = dense<-73> : tensor<7x5x8xi32>}> : () -> tensor<7x5x8xi32>
    %5 = tosa.minimum %0, %1 : (tensor<10x8x3xi8>, tensor<1x8x1xi8>) -> tensor<10x8x3xi8>
    %6 = tosa.bitwise_and %5, %5 : (tensor<10x8x3xi8>, tensor<10x8x3xi8>) -> tensor<10x8x3xi8>
    %7 = tosa.reduce_min %6 {axis = 0 : i32} : (tensor<10x8x3xi8>) -> tensor<1x8x3xi8>
    %8 = tosa.logical_right_shift %7, %7 : (tensor<1x8x3xi8>, tensor<1x8x3xi8>) -> tensor<1x8x3xi8>
    %9 = tosa.floor %2 : (tensor<7x3x8x6xf32>) -> tensor<7x3x8x6xf32>
    %10 = tosa.const_shape  {values = dense<[1, 4, 6]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %11 = tosa.reshape %8, %10 : (tensor<1x8x3xi8>, !tosa.shape<3>) -> tensor<1x4x6xi8>
    %12 = tosa.sigmoid %9 : (tensor<7x3x8x6xf32>) -> tensor<7x3x8x6xf32>
    %13 = tosa.const_shape  {values = dense<[1, 2, 2, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %14 = tosa.tile %12, %13 : (tensor<7x3x8x6xf32>, !tosa.shape<4>) -> tensor<7x6x16x12xf32>
    %15 = tosa.intdiv %3, %4 : (tensor<7x5x8xi32>, tensor<7x5x8xi32>) -> tensor<7x5x8xi32>
    %16 = tosa.add %14, %14 : (tensor<7x6x16x12xf32>, tensor<7x6x16x12xf32>) -> tensor<7x6x16x12xf32>
    %cast = tensor.cast %11 : tensor<1x4x6xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %15 : tensor<7x5x8xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %16 : tensor<7x6x16x12xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

