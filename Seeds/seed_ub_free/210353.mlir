module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.464600e+02> : tensor<5x2x3x4xf32>}> : () -> tensor<5x2x3x4xf32>
    %1 = "tosa.const"() <{values = dense<56> : tensor<8x2xi16>}> : () -> tensor<8x2xi16>
    %2 = "tosa.const"() <{values = dense<85> : tensor<1x1xi16>}> : () -> tensor<1x1xi16>
    %3 = tosa.reciprocal %0 : (tensor<5x2x3x4xf32>) -> tensor<5x2x3x4xf32>
    %4 = tosa.reduce_max %3 {axis = 1 : i32} : (tensor<5x2x3x4xf32>) -> tensor<5x1x3x4xf32>
    %5 = tosa.const_shape  {values = dense<[1, 3, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.tile %4, %5 : (tensor<5x1x3x4xf32>, !tosa.shape<4>) -> tensor<5x3x3x4xf32>
    %7 = tosa.ceil %6 : (tensor<5x3x3x4xf32>) -> tensor<5x3x3x4xf32>
    %8 = tosa.log %7 : (tensor<5x3x3x4xf32>) -> tensor<5x3x3x4xf32>
    %9 = tosa.bitwise_or %1, %2 : (tensor<8x2xi16>, tensor<1x1xi16>) -> tensor<8x2xi16>
    %cast = tensor.cast %8 : tensor<5x3x3x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<8x2xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

