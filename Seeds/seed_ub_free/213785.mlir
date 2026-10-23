module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<95> : tensor<7x9x8x7xi16>}> : () -> tensor<7x9x8x7xi16>
    %1 = "tosa.const"() <{values = dense<-1.744600e+02> : tensor<3x8xf32>}> : () -> tensor<3x8xf32>
    %2 = tosa.reduce_max %0 {axis = 2 : i32} : (tensor<7x9x8x7xi16>) -> tensor<7x9x1x7xi16>
    %3 = tosa.reduce_max %2 {axis = 1 : i32} : (tensor<7x9x1x7xi16>) -> tensor<7x1x1x7xi16>
    %4 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %5 = tosa.transpose %3 {perms = array<i32: 0, 3, 1, 2>} : (tensor<7x1x1x7xi16>) -> tensor<7x7x1x1xi16>
    %6 = tosa.log %1 : (tensor<3x8xf32>) -> tensor<3x8xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7x7x1x1xi16>}> : () -> tensor<7x7x1x1xi16>
    %s0 = tosa.maximum %5, %c0 : (tensor<7x7x1x1xi16>, tensor<7x7x1x1xi16>) -> tensor<7x7x1x1xi16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<7x7x1x1xi16>}> : () -> tensor<7x7x1x1xi16>
    %s1 = tosa.minimum %s0, %c1 : (tensor<7x7x1x1xi16>, tensor<7x7x1x1xi16>) -> tensor<7x7x1x1xi16>
    %7 = tosa.arithmetic_right_shift %5, %s1 {round = false} : (tensor<7x7x1x1xi16>, tensor<7x7x1x1xi16>) -> tensor<7x7x1x1xi16>
    %8 = tosa.const_shape  {values = dense<[2, 2, 2, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %9 = tosa.tile %7, %8 : (tensor<7x7x1x1xi16>, !tosa.shape<4>) -> tensor<14x14x2x1xi16>
    %10 = tosa.abs %6 : (tensor<3x8xf32>) -> tensor<3x8xf32>
    %cast = tensor.cast %9 : tensor<14x14x2x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %10 : tensor<3x8xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}