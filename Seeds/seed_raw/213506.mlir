module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-149> : tensor<5xi16>}> : () -> tensor<5xi16>
    %1 = "tosa.const"() <{values = dense<-1.323000e+02> : tensor<7x4x2xf32>}> : () -> tensor<7x4x2xf32>
    %2 = tosa.reverse %0 {axis = 0 : i32} : (tensor<5xi16>) -> tensor<5xi16>
    %3 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<5xi16>) -> tensor<1xi16>
    %4 = tosa.clamp %3 {max_val = 158 : i16, min_val = 57 : i16} : (tensor<1xi16>) -> tensor<1xi16>
    %5 = tosa.logical_left_shift %4, %4 : (tensor<1xi16>, tensor<1xi16>) -> tensor<1xi16>
    %6 = tosa.bitwise_or %5, %5 : (tensor<1xi16>, tensor<1xi16>) -> tensor<1xi16>
    %7 = tosa.reciprocal %1 : (tensor<7x4x2xf32>) -> tensor<7x4x2xf32>
    %8 = tosa.reciprocal %7 : (tensor<7x4x2xf32>) -> tensor<7x4x2xf32>
    %9 = tosa.const_shape  {values = dense<[28, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %10 = tosa.reshape %8, %9 : (tensor<7x4x2xf32>, !tosa.shape<2>) -> tensor<28x2xf32>
    %cast = tensor.cast %6 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %10 : tensor<28x2xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

