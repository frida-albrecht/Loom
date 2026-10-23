module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<120> : tensor<8x7x3x4xi16>}> : () -> tensor<8x7x3x4xi16>
    %1 = "tosa.const"() <{values = dense<-56> : tensor<8x1x1x1xi16>}> : () -> tensor<8x1x1x1xi16>
    %2 = "tosa.const"() <{values = dense<-1.670700e+02> : tensor<1x10xf32>}> : () -> tensor<1x10xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<8x7x3x4xi16>, tensor<8x1x1x1xi16>) -> tensor<8x7x3x4xi16>
    %4 = tosa.const_shape  {values = dense<[3, 2, 2, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.tile %3, %4 : (tensor<8x7x3x4xi16>, !tosa.shape<4>) -> tensor<24x14x6x12xi16>
    %6 = tosa.reduce_sum %5 {axis = 2 : i32} : (tensor<24x14x6x12xi16>) -> tensor<24x14x1x12xi16>
    %7 = tosa.log %2 : (tensor<1x10xf32>) -> tensor<1x10xf32>
    %cast = tensor.cast %6 : tensor<24x14x1x12xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<1x10xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

