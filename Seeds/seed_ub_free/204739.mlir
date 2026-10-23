module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.805600e+02> : tensor<3x4x4x10xf32>}> : () -> tensor<3x4x4x10xf32>
    %1 = "tosa.const"() <{values = dense<-117> : tensor<2x1x1x4xi16>}> : () -> tensor<2x1x1x4xi16>
    %2 = tosa.sigmoid %0 : (tensor<3x4x4x10xf32>) -> tensor<3x4x4x10xf32>
    %3 = tosa.floor %2 : (tensor<3x4x4x10xf32>) -> tensor<3x4x4x10xf32>
    %4 = tosa.bitwise_not %1 : (tensor<2x1x1x4xi16>) -> tensor<2x1x1x4xi16>
    %5 = tosa.const_shape  {values = dense<[2, 1, 2, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.tile %4, %5 : (tensor<2x1x1x4xi16>, !tosa.shape<4>) -> tensor<4x1x2x4xi16>
    %cast = tensor.cast %3 : tensor<3x4x4x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<4x1x2x4xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

