module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.760300e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = "tosa.const"() <{values = dense<-43> : tensor<4x8x5x2xi16>}> : () -> tensor<4x8x5x2xi16>
    %2 = "tosa.const"() <{values = dense<92> : tensor<4x8x1x1xi16>}> : () -> tensor<4x8x1x1xi16>
    %3 = "tosa.const"() <{values = dense<-25> : tensor<6x1xi32>}> : () -> tensor<6x1xi32>
    %4 = "tosa.const"() <{values = dense<59> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %5 = tosa.sigmoid %0 : (tensor<3xf32>) -> tensor<3xf32>
    %6 = tosa.exp %5 : (tensor<3xf32>) -> tensor<3xf32>
    %7 = tosa.bitwise_xor %1, %2 : (tensor<4x8x5x2xi16>, tensor<4x8x1x1xi16>) -> tensor<4x8x5x2xi16>
    %8 = tosa.reciprocal %6 : (tensor<3xf32>) -> tensor<3xf32>
    %9 = tosa.sigmoid %8 : (tensor<3xf32>) -> tensor<3xf32>
    %10 = tosa.concat %9, %9 {axis = 0 : i32} : (tensor<3xf32>, tensor<3xf32>) -> tensor<6xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x8x5x2xi16>}> : () -> tensor<4x8x5x2xi16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<4x8x5x2xi16>}> : () -> tensor<4x8x5x2xi16>
    %s0 = tosa.maximum %7, %c0 : (tensor<4x8x5x2xi16>, tensor<4x8x5x2xi16>) -> tensor<4x8x5x2xi16>
    %s1 = tosa.minimum %s0, %c1 : (tensor<4x8x5x2xi16>, tensor<4x8x5x2xi16>) -> tensor<4x8x5x2xi16>
    %11 = tosa.logical_right_shift %7, %s1 : (tensor<4x8x5x2xi16>, tensor<4x8x5x2xi16>) -> tensor<4x8x5x2xi16>
    %12 = tosa.tanh %10 : (tensor<6xf32>) -> tensor<6xf32>
    %13 = tosa.abs %7 : (tensor<4x8x5x2xi16>) -> tensor<4x8x5x2xi16>
    %14 = tosa.const_shape  {values = dense<[3, 2, 2, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %15 = tosa.tile %13, %14 : (tensor<4x8x5x2xi16>, !tosa.shape<4>) -> tensor<12x16x10x4xi16>
    %16 = tosa.reverse %15 {axis = 1 : i32} : (tensor<12x16x10x4xi16>) -> tensor<12x16x10x4xi16>
    %17 = tosa.intdiv %3, %4 : (tensor<6x1xi32>, tensor<1x1xi32>) -> tensor<6x1xi32>
    %18 = tosa.bitwise_and %11, %13 : (tensor<4x8x5x2xi16>, tensor<4x8x5x2xi16>) -> tensor<4x8x5x2xi16>
    %cast = tensor.cast %12 : tensor<6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %16 : tensor<12x16x10x4xi16> to tensor<*xi16>
    %cast_1 = tensor.cast %17 : tensor<6x1xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %18 : tensor<4x8x5x2xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI16(%cast_2) : (tensor<*xi16>) -> ()
    return
  }
}